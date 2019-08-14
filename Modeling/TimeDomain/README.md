# Time-domain seismic modeling  

##  DESCRIPTION
This module provides a Julia framework for 2D and 3D seismic modeling in the time domain. The module offers functions for solving the forward and adjoint acoustic wave equation as well as the linearized acoustic wave equation (Born modeling). For solving wave equations, we use Devito, a finite difference domain specific language compiler that generates optimized parallel C code.

 Our toolbox is based on abstract matrix-free linear operators, that allows to easily formulate algorithms for PDE-constrained optimization problems, such as least squares migration (LSRTM) and full waveform inversion (FWI).

##  COPYRIGHT
 You may use this code only under the conditions and terms of the
 license contained in the files LICENSE or COPYING provided with this
 source code. If you do not agree to these terms you may not use this
 software.

##  INSTALLATION

###  Software in SLIM-release-jlapps (this) repository
 Follow the instructions in the [INSTALLATION.md](../../INSTALLATION.md)
 file (located in the home directory of this software repository) to install necessary components.

##  DOCUMENTATION
https://slim.gatech.edu/SoftwareDemos/Julia/Modeling/modeling_documentation.html

###  Preparing shell environment
 You must setup your shell environment according to the steps listed in
 the README located in home directory of the software release.

###  Running applications/demos
This directory contains four example scripts that demonstrate how to set up modeling examples in 2D and 3D. The scripts ```modeling_basic_2D.jl``` and ```modeling_basic_3D.jl``` show how to set up seismic surveys in which the receiver geometry does not change for the different source experiments, which corresponds to marine seismic surveys with ocean bottom nodes or some land surveys with constant geophone geometry. The scripts ```modeling_advanced_2D.jl``` and ```modelin_advanced_3D.jl``` demonstrate how to set up seismic surveys with varying receiver geometries, i.e. marine streamer acquisitions or more flexible land acquisitions. 

All demo scripts generate data for a seismic survey with four source locations. The scripts can be run either in parallel using four Julia workers or a single worker only. To run the scripts interactively, start a Julia session with one worker by typing ```julia``` into the terminal command line or ```julia -p 4``` to start an interactive session with four workers. The scripts are run by typing ```include("modeling_basic_2D.jl")``` into the Julia command line.

The scripts generate seismic shot records ```d``` and linearized shot records ```dD```. To plot the first shot record, type ```imshow(d.data[1])``` into the Julia command line. To quit Julia, type ```quit()```.

####  Hardware requirements
The example scripts use a very small velocity model (180^3 gridpoints for 3D) and should be executable on a laptop or desktop computer. The 2D example requires less than 1 GB of RAM and the 3D example needs approximately 12 GB of RAM. 

##  SUPPORT
 You may contact SLIM's developers of SINBAD software via issue tracker for this repository. We do not have resources to acctively support public version of our software. However, we will try to answert the questions as much as possible.

