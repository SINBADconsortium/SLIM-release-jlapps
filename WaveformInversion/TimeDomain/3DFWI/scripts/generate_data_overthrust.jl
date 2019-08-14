# Generate 3D data for the overthrust model
# Author: Philipp Witte, pwitte@eoas.ubc.ca
# Date: May 2017
#

Pkg.checkout("opesciSLIM","development")
using PyCall, PyPlot, JLD, HDF5, opesciSLIM.TimeModeling

# Load velocity model
n,d,o,m = h5open("../data/overthrust_3D_true_model.h5","r") do file
	read(file, "n", "d", "o", "m")
end

# Set up model structure
model = Model((n[1],n[2],n[3]), (d[1],d[2],d[3]), (o[1],o[2],o[3]), m)	# need n,d,o as tuples and m0 as array

# Bound constraints
vmin = ones(Float32,model.n) + 0.3
vmax = ones(Float32,model.n) + 5.5

# Slowness squared [s^2/km^2]
mmin = vec((1./vmax).^2.)
mmax = vec((1./vmin).^2.)

# Set up source grid
nsrc = 97^2
xsrc = 400.f0:200.f0:19600.f0	# 500 m space from boundary
ysrc = 400.f0:200.f0:19600.f0
zsrc = 50.f0
(xsrc,ysrc,zsrc) = setup_3D_grid(xsrc,ysrc,zsrc)
xsrc = convertToCell(xsrc)
ysrc = convertToCell(ysrc)
zsrc = convertToCell(zsrc)
timeS = 3000.f0
dtS = 4.f0
srcGeometry = Geometry(xsrc,ysrc,zsrc;dt=dtS,t=timeS)

## Set up receivers
xmin = 100.f0; xmax = 19900.f0
ymin = 100.f0; ymax = 19900.f0
offset = 6000.f0
nxrec = 240
nyrec = 240
xrec = Array{Any,1}(nsrc)
yrec = Array{Any,1}(nsrc)
zrec = Array{Any}(nsrc)
for j=1:nsrc
	xsrc[j] - offset < xmin ? xlocal1 = xmin : xlocal1 = xsrc[j] - offset
	xsrc[j] + offset > xmax ? xlocal2 = xmax : xlocal2 = xsrc[j] + offset
	ysrc[j] - offset < ymin ? ylocal1 = ymin : ylocal1 = ysrc[j] - offset
	ysrc[j] + offset > ymax ? ylocal2 = ymax : ylocal2 = ysrc[j] + offset
	xlocal = xlocal1:50.f0:xlocal2
	ylocal = ylocal1:50.f0:ylocal2
	zlocal = 500.f0
	(xlocal,ylocal,zlocal) = setup_3D_grid(xlocal,ylocal,zlocal)
	xrec[j] = xlocal
	yrec[j] = ylocal
	zrec[j] = zlocal
end
timeR = 3000.f0	# receiver recording time [ms]
dtR = 4.f0	# receiver sampling interval
recGeometry = Geometry(xrec,yrec,zrec;dt=dtR,t=timeR)

# Set up source
f0 = 0.008
wavelet = source(timeS,dtS,f0)

# Info for modeling operators
ntComp = get_computational_nt(srcGeometry,recGeometry,model)
info = Info(prod(model.n),nsrc,ntComp)

#######################################################################

# Set up modeling options
opt = Options(limit_m = true,
			  save_data_to_disk = true,
			  file_path = "../data",
 			  file_name = "overthrust_3D_shot_",
			  save_rate = 14.
			  )

# Set up operators
Pr = joProjection(info,recGeometry)
Ps = joProjection(info,srcGeometry)
F = joModeling(info,model; options=opt)
q = joData(srcGeometry,wavelet)

# Generate data
dobs = Pr*F*Ps'*q


