# Time-domain seismic imaging 

##  DESCRIPTION
This module provides the tools for reverse time migration (RTM) and least squares RTM (LSRTM) with and without sparsity contraints. Furthermore this module contains several preconditioners for LSRTM, namely model- and data-space topmutes, depth scaling and data scaling.

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
https://slim.gatech.edu/SoftwareDemos/Julia/Imaging/imaging_documentation.html

##  RUNNING

###  Preparing shell environment
 You must setup your shell environment according to the steps listed in
 the README located in home directory of the software release.

###  Running applications/demos
This directory contains two example scripts for running sparsity-promoting LSRTM on a small test model (```lsrtm_2D.jl```) and standard LSRTM on the 2D Marmousi model (```lsrtm_marmousi.jl```).

The first script runs 2D sparsity-promoting least squares RTM with source subsampling on a small test model. The script generates 10 linearized shot records for a small horizontally layered model and then runs SP-LSRTM with the linearized Bregman method. To run this script, start an interactive Julia session by typing ```julia -p n``` into the shell command line, where n is the number of workers. Since the example script uses a very small 2D model, it is sufficient to run the script with a single worker. After starting a Julia session, type ```include("lsrtm_2D.jl")``` into the Julia command line to run the example. The script runs 10 iterations of SP-LSRTM with 2 shots per iterations. After the script finishes, the results can be plotted by typing ```imshow(image)``` into the command line. To quit Julia, type ```quit()```.

The second script performs 2D least squares RTM on the 2D Marmousi model using source subsampling. First, fetch the data from the FTP server by executing either the ```SConstruct``` script from the ```data``` directory (requires RSF) or the ```fetch_data.sh``` shell script. Then start Julia with the specified number of workers and execute the script by typing ```include("lsrtm_marmousi.jl")```. The script runs for 32 iterations, using 10 randomly selected shots per iteration.

####  Hardware requirements
The ```lsrtm_2D.jl``` script requires less than 1 GB of memory and can be run using between 1 and 10 workers. It should therefore be executable on any PC or laptop. The ```lsrtm_marmousi.jl``` script requires approximately 5 GB of memory if run in serial and 50 GB if run in parallel on 10 workers.

##  SUPPORT
 You may contact SLIM's developers of SINBAD software via issue tracker for this repository. We do not have resources to acctively support public version of our software. However, we will try to answert the questions as much as possible.
