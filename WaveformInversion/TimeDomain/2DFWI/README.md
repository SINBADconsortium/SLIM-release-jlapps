# Time-domain full-waveform inversion

##  DESCRIPTION
This module provides examples of how to perform 2D full-waveform inversion using Devito and our Julia framework. The example scripts demonstrate how to set up an objective function that can be passed to optimization libraries with a specified optimization algorithm.

##  COPYRIGHT
 You may use this code only under the conditions and terms of the
 license contained in the files LICENSE or COPYING provided with this
 source code. If you do not agree to these terms you may not use this
 software.

##  INSTALLATION

###  Software in SLIM-release-jlapps (this) repository
 Follow the instructions in the [INSTALLATION.md](../../INSTALLATION.md)
 file (located in the home directory of this software repository) to install necessary components.

##  RUNNING

###  Preparing shell environment
 You must setup your shell environment according to the steps listed in
 the README located in home directory of the software release.

###  Running applications/demos
This directory contains an example script for running 2D FWI of the Overthrust velocity model. The script loads the observed data in SEG-Y format and a starting model in HDF5 format. The examples show how to set up an objective function that can passed to the minConf optimization library for a specified optimization algorithm. In this case, we perform several iterations of spectral projected gradient, with a random subset of 20 sources and shot records in each iteration.

To run the example, first download the data and the velocity model by going to the ```data``` directory and executing either the ```SConstruct``` script (requires RSF) or the ```fetch_data.sh``` shell script (```./fetch_data.sh```).

To run the example script, go to the ```scripts``` directory and start an interactive Julia session by typing ```julia -p n``` into the shell command line, where n is the number of workers. The script uses a fairly small velocity model (801 by 207 grid points) and can be run on a single worker, but the example will run faster using multiple workers. After starting a Julia session, type ```include("fwi_overthrust_2D.jl")``` into the Julia command line to run the example. The script runs FWI with stochastic SPG using 20 shots in each iteration for a maximum of 20 function evaluations. After finishing, the script generates several figures with the initial model, result and convergence. To quit Julia, type ```quit()```.

####  Hardware requirements
Executing this script in serial requires approximately 150 MB of memory. Running the script fully parallel (up to 20 workers) requires around 3GB of memory.

##  SUPPORT
 You may contact SLIM's developers of SINBAD software via issue tracker for this repository. We do not have resources to acctively support public version of our software. However, we will try to answert the questions as much as possible.

