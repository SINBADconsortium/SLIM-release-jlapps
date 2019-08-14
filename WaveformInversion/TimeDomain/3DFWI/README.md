# Time-domain full-waveform inversion

##  DESCRIPTION
This module provides examples of how to perform 3D full-waveform inversion using Devito and our Julia framework. The example scripts demonstrate how to set up an objective function that can be passed to optimization libraries with a specified optimization algorithm.

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
This directory contains an example script for running 3D FWI of the Overthrust velocity model. The generate_data_overthrust.jl script models the observed data, which consists of 9409 3D shot records with 3 seconds recording time. The full generated data volume has a size of approximately 1.2 TB. The fwi_overthrust_3D.jl script shows how to set up an objective function that can passed to the minConf optimization library for a specified optimization algorithm. In this case, we perform several iterations of spectral projected gradient, with a random subset of 1080 sources and shot records in each iteration.

To run the example, first download the true and the initial model, by going to the ```data``` directory and executing either the ```SConstruct``` script (requires RSF) or the ```fetch_data.sh``` shell script (```./fetch_data.sh```).

To run the data generation script, go to the ```scripts``` directory and start an interactive Julia session by typing ```julia -p n``` into the shell command line, where n is the number of workers. Then type ```include("generate_data_overthrust.jl")``` to execute the script. This will generate the observed shot records as seperate SEG-Y files in the specified directory. Make sure you have enough disk space available (the full dataset is around 1.2 TB). To perform 3D FWI, specifiy the file path to the data in the ```fwi_overthrust_3D.jl``` script and execute the script by typing ```include("fwi_overthrust_3D.jl)```. The example runs FWI using a spectral-projected gradient algorithm with a randomized subset of 1080 shots per function evaluation for a maximum number of 15 function evaluations.

####  Hardware requirements
Executing this script in serial requires approximately 80 GB of memory (per gradient). 

##  SUPPORT
 You may contact SLIM's developers of SINBAD software via issue tracker for this repository. We do not have resources to acctively support public version of our software. However, we will try to answert the questions as much as possible.
