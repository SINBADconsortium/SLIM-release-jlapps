# LSRTM of Marmousi using stochastic gradient descent
# Author: Philipp Witte, pwitte@eoas.ubc.ca
# Date: August 2017

using PyCall,PyPlot,HDF5,opesciSLIM.TimeModeling,opesciSLIM.LeastSquaresMigration,SeisIO

# Load migration velocity model
n,d,o,m0 = h5open("../data/marmousi_migration_velocity.h5","r") do file
	read(file, "n", "d", "o", "m0")
end

# Load data
block = segy_read("../data/marmousi_2D.segy")
dD = joData(block)

# Set up model structure
model0 = Model((n[1],n[2]), (d[1],d[2]), (o[1],o[2]), m0)

# Set up wavelet
src_geometry = Geometry(block; key="source", segy_depth_key="SourceDepth")
wavelet = source(src_geometry.t[1],src_geometry.dt[1],0.03)	# 30 Hz wavelet
q = joData(src_geometry,wavelet)

# Set up info structure
ntComp = get_computational_nt(q.geometry,dD.geometry,model0)	# no. of computational time steps
info = Info(prod(model0.n),dD.nsrc,ntComp)

###################################################################################################

# Setup operators
F = joModeling(info,model0,q.geometry,dD.geometry)
J = joJacobian(F,q)

# Right-hand preconditioners (model topmute)
Mr = opTopmute(model0.n,42,10)	# mute up to grid point 42, with 10 point taper

# Stochastic gradient
x = zeros(Float32,info.n)
batchsize = 10
niter = 32
fval = zeros(Float32,niter)
for j=1:niter
	println("Iteration: ", j)

	# Select batch and set up left-hand preconditioner
	idx = randperm(dD.nsrc)[1:batchsize]
	Jsub = subsample(J,idx)
	dsub = subsample(dD,idx)
	Ml = opMarineTopmute(30,dsub.geometry)	# data topmute starting at nz=30

	# Compute residual and gradient
	r = Ml*Jsub*Mr*x - Ml*dsub
	g = Mr'*Jsub'*Ml'*r

	# Step size and update variable
	fval[j] = .5*norm(r)^2
	t = norm(r)^2/norm(g)^2
	x -= t*g
end

# Save result
h5open("marmousi_lsrtm.h5", "w") do file
	write(file, "x", reshape(x,model0.n))
end

figure(); imshow(reshape(x,model0.n)')

