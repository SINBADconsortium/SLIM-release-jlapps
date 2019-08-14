# Example for advanced 3D modeling:
# The receiver locations, sampling intervals for source and receiver,
# number of samples, as well as the wavelets can be different for each 
# experiment.
#
# Author: Philipp Witte, pwitte@eos.ubc.ca
# Date: January 2017
#

using PyCall, PyPlot, opesciSLIM.TimeModeling

## Set up model structure
n = (110,100,90)	# no. of gridpoints (x,y,z)
d = (10.,10.,10.)	# grid spacing [m]
o = (0.,0.,0.)	# origin [m]

# Velocity [km/s]
v = ones(Float32,n) + 0.4f0
v0 = ones(Float32,n) + 0.4f0
v[:,:,Int(round(end/2)):end] = 4.0f0
rho = ones(Float32,n)

# Slowness squared [s^2/km^2]
m = (1./v).^2
m0 = (1./v0).^2
dm = vec(m - m0)

# Setup model structure
nsrc = 4
model = Model(n,d,o,m)	# to include density call Model(n,d,o,m,rho)
model0 = Model(n,d,o,m0)

## Set up receiver geometry
nxrec = [120 60 30 15]
nyrec = [80 40 30 60]

# receiver x position
xrec = Array{Any}(nsrc)
xrec[1] = linspace(50., 1150., nxrec[1])	# 120 receivers in x direction for experiment 1
xrec[2] = linspace(80., 100., nxrec[2])		# 60 receivers in x direction for experiment 2
xrec[3] = linspace(150., 1050., nxrec[3])	# 30 receivers in x direction for experiment 3
xrec[4] = linspace(250., 900., nxrec[4])	# 15 receivers in x direction for experiment 4

# receiver y position
yrec = Array{Any}(nsrc)
yrec[1] = linspace(100., 1100., nyrec[1])	# 80 receivers in y direction for experiment 1 
yrec[2] = linspace(150., 900., nyrec[2])	# ...
yrec[3] = linspace(200., 1000., nyrec[3])
yrec[4] = linspace(250., 800., nyrec[4])

# receiver z position
zrec = Array{Any}(nsrc)
zrec[1] = 60.
zrec[2] = 50.
zrec[3] = 40.
zrec[4] = 90.

# Setup 3D receiver vectors
(xrec, yrec, zrec) = setup_3D_grid(xrec, yrec, zrec)

# receiver sampling and recording time
timeR = Array{Any}(nsrc)
dtR = Array{Any}(nsrc)
timeR[1] = 1000.	# receiver recording length for each experiment
timeR[2] = 900.
timeR[3] = 800.
timeR[4] = 700.
dtR[1] = 4.	# receiver sampling interval
dtR[2] = 2.
dtR[3] = 3.
dtR[4] = 4.

# Set up receiver structure
recGeometry = Geometry(xrec,yrec,zrec;dt=dtR,t=timeR)

## Set up source geometry
xsrc = Array{Any}(nsrc)
ysrc = Array{Any}(nsrc)
zsrc = Array{Any}(nsrc)

# source x position
xsrc[1] = [200, 400]	# inject two sources
xsrc[2] = 500
xsrc[3] = 800
xsrc[4] = 1100

# source y position
ysrc[1] = [250.,600.]
ysrc[2] = 400.
ysrc[3] = 700.
ysrc[4] = 500.

# source z position
zsrc[1] = [100. 110.]	# inject two sources
zsrc[2] = 110.
zsrc[3] = 120.
zsrc[4] = 130.

# source sampling and number of time steps
timeS = Array{Any}(nsrc)
dtS = Array{Any}(nsrc)
timeS[1] = 1200.	# source length for each experiment
timeS[2] = 1100.
timeS[3] = 900.
timeS[4] = 700.
dtS[1] = 3.	# source sampling interval
dtS[2] = 4.
dtS[3] = 2.
dtS[4] = 2.

# Set up source structure
srcGeometry = Geometry(xsrc,ysrc,zsrc;dt=dtS,t=timeS)

# Wavelets
f0 = [0.01, 0.015, 0.005, 0.02]
wavelet = Array{Any}(nsrc)
wavelet[1] = source(timeS[1],dtS[1],f0[1])
wavelet[1] = [wavelet[1] wavelet[1]]
wavelet[2] = source(timeS[2],dtS[2],f0[2])
wavelet[3] = source(timeS[3],dtS[3],f0[3])
wavelet[4] = source(timeS[4],dtS[4],f0[4])

# Info structure for linear operators
ntComp = get_computational_nt(srcGeometry,recGeometry,model)	# no. of computational time steps
info = Info(prod(n),nsrc,ntComp)

###################################################################################################

# Setup projection operators
Pr = joProjection(info, recGeometry)
F = joModeling(info, model)
F0 = joModeling(info, model0)
Ps = joProjection(info, srcGeometry)
q = joData(srcGeometry, wavelet)

# Nonlinear modeling
d = Pr*F*Ps'*q
qad = Ps*F'*Pr'*d

# Linearized modeling
J = joJacobian(Pr*F0*Ps',q)	# equivalent to J = joSetupJacobian(Ffull,q)
dD = J*dm
rtm = J'*dD

# Plot results
figure(); imshow(d.data[1][:,1:500], vmin=-1e-1, vmax=1e-1)
rtm = reshape(rtm,model.n)
figure(); imshow(rtm[:,50,:]', ColorMap("gray"))






