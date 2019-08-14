# Example for 2D sparsity-promoting LSRTM with source subsampling
# Author: Philipp Witte, pwitte@eos.ubc.ca
# Date: January 2017
#

using PyCall
using PyPlot
using opesciSLIM.TimeModeling
using opesciSLIM.LeastSquaresMigration

## Set up model structure
n = (120,100)	# (x,y,z) or (x,z)
d = (10.,10.)
o = (0.,0.)

# Velocity [km/s]
v = ones(Float32,n) + 0.4f0
v0 = ones(Float32,n) + 0.4f0
v[:,40:70] = 3.0f0
v[:,71:end] = 4.0f0
rho = ones(Float32,n)

# Slowness squared [s^2/km^2]
m = (1./v).^2
m0 = (1./v0).^2
dm = vec(m - m0)

# Setup info and model structure
nsrc = 4
model = Model(n,d,o,m)	# to include density call Model(n,d,o,m,rho)
model0 = Model(n,d,o,m0)

## Set up receiver geometry
nxrec = 120
xrec = linspace(50.,1150.,nxrec)
yrec = 0.
zrec = linspace(50.,50.,nxrec)

# receiver sampling and recording time
timeR = 1000.	# receiver recording time [ms]
dtR = 4.	# receiver sampling interval

# Set up receiver structure
recGeometry = Geometry(xrec,yrec,zrec;dt=dtR,t=timeR,nsrc=nsrc)

## Set up source geometry (cell array with source locations for each shot)
xsrc = convertToCell(linspace(100,1000,nsrc))
ysrc = convertToCell(linspace(0,0,nsrc))
zsrc = convertToCell(linspace(20,20,nsrc))

# source sampling and number of time steps
timeS = 1000.	# source length in [ms]
dtS = 2.	# source sampling interval

# Set up source structure
srcGeometry = Geometry(xsrc,ysrc,zsrc;dt=dtS,t=timeS)

# setup wavelet
f0 = 0.01
wavelet = source(timeS,dtS,f0)

# Info structure for linear operators
ntComp = get_computational_nt(srcGeometry,recGeometry,model)	# no. of computational time steps
info = Info(prod(n),nsrc,ntComp)

###################################################################################################

# Setup operators
F = joModeling(info,model0,srcGeometry,recGeometry)
q = joData(srcGeometry,wavelet)
J = joJacobian(F,q)

# Observed data
dD = J*dm

# Least squares migration
image = linbreg_lsrtm(J, dD; iterations=5, shots_per_iteration=2)




