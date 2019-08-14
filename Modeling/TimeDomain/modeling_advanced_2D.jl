# Example for advanced 2D modeling:
# The receiver locations, sampling intervals for source and receiver,
# number of samples, as well as the wavelets can be different for each 
# experiment.
#
# Author: Philipp Witte, pwitte@eos.ubc.ca
# Date: January 2017
#

using PyCall, PyPlot, opesciSLIM.TimeModeling

## Set up model structure
n = (120,100)	# (x,y,z) or (x,z)
d = (10.,10.)
o = (0.,0.)

# Velocity [km/s]
v = ones(Float32,n) + 0.4f0
v0 = ones(Float32,n) + 0.4f0
v[:,Int(round(end/2)):end] = 4.0f0
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
nxrec = [120 160 130 115] # no. of receivers for the four experiments
nyrec = 1
xrec = Array{Any}(nsrc)
yrec = Array{Any}(nsrc)
zrec = Array{Any}(nsrc)

# Receiver x position. Each cell contains the coordinates for the corresponding experiment
xrec[1] = linspace(50.,1150.,nxrec[1])	# 101 receivers in x direction for experiment 1
xrec[2] = linspace(100.,1000.,nxrec[2])	# 50 receivers in x direction for experiment 2
xrec[3] = linspace(150.,900.,nxrec[3])	# 25 receivers in x direction for experiment 3
xrec[4] = linspace(250.,800.,nxrec[4])	# 13 receivers in x direction for experiment 4

# Receiver y position
yrec[1] = 0.	# 0 receivers in y direction for all experiments
yrec[2] = 0.
yrec[3] = 0.
yrec[4] = 0.

# Receiver z position
zrec[1] = linspace(100.,100.,nxrec[1])
zrec[2] = linspace(120.,120.,nxrec[2])
zrec[3] = linspace(80.,100.,nxrec[3])
zrec[4] = linspace(80.,140.,nxrec[4])

# receiver sampling and recording time
timeR = Array{Any}(nsrc)
dtR = Array{Any}(nsrc)
timeR[1] = 950.	# receiver recording length for each experiment
timeR[2] = 800.
timeR[3] = 1000.
timeR[4] = 880.
dtR[1] = 4.	# receiver sampling interval for each experiment
dtR[2] = 2.
dtR[3] = 3.
dtR[4] = 4.

# Setup receiver structure
recGeometry = Geometry(xrec,yrec,zrec;dt=dtR,t=timeR)

## Set up source geometry
xsrc = Array{Any}(nsrc)
ysrc = Array{Any}(nsrc)
zsrc = Array{Any}(nsrc)

# Source x position for each of the four experiments
xsrc[1] = [200, 400]	# inject two sources in experiment 1
xsrc[2] = 500
xsrc[3] = 800
xsrc[4] = 600

# Source y position
ysrc[1] = [0.,0.]
ysrc[2] = 0.
ysrc[3] = 0.
ysrc[4] = 0.

# Source z position
zsrc[1] = [50. 65.]	# inject two sources
zsrc[2] = 55.
zsrc[3] = 60.
zsrc[4] = 65.

# Source sampling and number of time steps
timeS = Array{Any}(nsrc)
dtS = Array{Any}(nsrc)
timeS[1] = 1000.	# source length for each experiment
timeS[2] = 900.
timeS[3] = 1200.
timeS[4] = 950.
dtS[1] = 3.	# source sampling interval for each experiment
dtS[2] = 4.
dtS[3] = 2.
dtS[4] = 2.

# Set up source structure
srcGeometry = Geometry(xsrc,ysrc,zsrc;dt=dtS,t=timeS)

# setup wavelets
f0 = [0.01, 0.015, 0.005, 0.02]	# source peak frequencies
wavelet = Array{Any}(nsrc)
wavelet[1] = source(timeS[1],dtS[1],f0[1])	
wavelet[1] = [wavelet[1] wavelet[1]]	# first experiments has two sources
wavelet[2] = source(timeS[2],dtS[2],f0[2])
wavelet[3] = source(timeS[3],dtS[3],f0[3])
wavelet[4] = source(timeS[4],dtS[4],f0[4])

# Info structure for linear operators
ntComp = get_computational_nt(srcGeometry,recGeometry,model)	# no. of computational time steps
info = Info(prod(n),nsrc,ntComp)

###################################################################################################

# Setup operators
Pr = joProjection(info,recGeometry)
F = joModeling(info,model)
F0 = joModeling(info,model0)
Ps = joProjection(info,srcGeometry)
q = joData(srcGeometry,wavelet)

Ffull = joModeling(info,model,srcGeometry,recGeometry)

# Nonlinear modeling
d = Pr*F*Ps'*q
qad = Ps*F'*Pr'*d

# Linearized modeling
J = joJacobian(Pr*F0*Ps',q)	# equivalent to J = joSetupJacobian(Ffull,q)
dD = J*dm	# returns data contain
rtm = J'*dD

# Plot results
figure(); imshow(d.data[1], vmin=-1e1, vmax=1e1)
figure(); imshow(reshape(rtm,model.n)', ColorMap("gray"))


