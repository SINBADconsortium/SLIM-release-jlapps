# INSTALLATION instructions
## 1 INTRODUCTION
 We provided simple installation scripts for each software package for
 your convenience; however, we cannot guarantee that they will be
 sufficient to successfully complete installation. Please, contact
 SLIM's developers (see SUPPORT section) with any questions or problems
 encountered during installation.
 
 Note, that installation of software in this repository requires
 network access. All Julia packages and supporting Python packages are
 downloaded during installation from on-line repositories and installed
 into user space, i.e. ~/.julia and ~/.local directories in your
 account. (The exception being update of Python’s Python package
 manager `pip`)
 
 The 3-rd party software packages needed by SLIM software release might
 require additional prerequisites depending on the version of the
 operating system and type and/or completeness of its installation.
 This installation was tested and completes successfully on full
 installation of x86_64 Linux with operating systems CentOS 6.6 or
 later (equivalent to RedHat 6.6 or later).
 
 If any step of the installation fails for the 3-rd party software, it
 might be more effective to consult first your IT support if some of
 the prerequisites are missing or the included web site for specific
 instructions suitable for your operating system.
 
 Note! This document covers only installation of SLIM-release-jlapps
 part of software release. For notes on installation of
 SLIM-release-comp refer to INSTALLATION file in [SLIM-release-comp]
 (https://github.com/SINBADconsortium/SLIM-release-comp) repository.
## 2 INSTALLATION STRATEGIES
 Here are the potential strategies for installing our software in
 single-/multi-user environment.
 
 Note, that each user must have a personal (or at the very least has to
 have write permissions) copy of SLIM-release-jlapps in order to to run
 any applications, since each application is configured to look for
 data and create directories inside of its own directory.
### 2.1 Complete user-owned installation
 Personal installation for single user, both SLIM-release-comp and
 SLIM-release-jlapps.
 
 User installs both SLIM-release-comp and SLIM-release-jlapps in
 personal directories.
### 2.2 Multi-user SLIM-release-comp installation
 Multi-user installation of SLIM-release-comp and personal installation
 of SLIM-release-jlapps. 
 
 Designated person instals SLIM-release-comp in common directory and
 user installs personal SLIM-release-jlapps.
### 2.3 Quick SLIM-release-jlapps only installation with local Miniconda Python
 Personal installation for single user, with MIniconda Python and
 without SLIM-release-comp.
## 3 DOWNLOADING
 In terminal, change directory to the location where you want to
 install the software and execute the following git command:
 
 	git clone git@github.com:SINBADconsortium/SLIM-release-jlapps.git
 
 and the cloned software will be in SLIM-release-jlapps sub-directory.
## 4 GIT BRANCHES
 SLIM is using master branch to develop/add software to repository.
 Since SLIM-release-jlapps is in the early development stage, the
 master branch is the only one available at the moment.
## 5 SHELL ENVIRONMENT
 First, you must configure your shell environment before you can
 proceed with installation.
### 5.1 Prepare environment.* script
#### 5.1.1 Make a copy of appropriate environment.* script template
 Open terminal window, change directory to the home of
 SLIM-release-jlapps and do either of the following:
##### 5.1.1.1 in bash-like shell execute
 	cp environment.sh.template environment.sh
##### 5.1.1.2 in csh-like shell execute
 	cp environment.csh.template environment.csh
#### 5.1.2 Edit and modify your copy of the  environment.* script
 Edit the file created above in an editor and make the following
 changes  accordingly to chosen installation strategy.
##### 5.1.2.1 Quick personal SLIM-release-jlapps only installation with local
 Miniconda Python
 In personal SLIM-release-jlapps/environment.{sh,csh}:
 
 - SLIM_COMP no change and points to dummy location
 - SLIM_JLAPPS points to absolute path of user's personal
 SLIM-release-jlapps  
 - SLIM_JLAPPS_RUNS points to $SLIM_JLAPPS
##### 5.1.2.2 Complete user-owned installation
 In personal SLIM-release-jlapps/environment.{sh,csh}:
 
 - SLIM_COMP points to absolute path of user's personal
 SLIM-release-comp  
 - SLIM_JLAPPS points to absolute path of user's personal
 SLIM-release-jlapps  
 - SLIM_JLAPPS_RUNS points to $SLIM_JLAPPS  
 
##### 5.1.2.3 Multi-user SLIM-release-comp installation
 In personal SLIM-release-jlapps/environment.{sh,csh}:
 
 - SLIM_COMP points to absolute path of common SLIM-release-comp  
 - SLIM_JLAPPS points to absolute path of user's personal
 SLIM-release-jlapps  
 - SLIM_JLAPPS_RUNS points to $SLIM_JLAPPS  
 
### 5.2 Importing shell environment
 In terminal window, in the home of SLIM-release-jlapps do either of
 the following:
#### 5.2.1 in bash-like shell execute
 	. environment.sh
#### 5.2.2 in csh-like shell execute
 	source environment.csh
#### 5.3 Loading the environment automatically (optional and for users only)
 Add the following to your default-shell's startup script to make the
 permanent change to the environment. You will not need then to source
 environment.sh/csh manually.
##### 5.3.1 for bash-like shell add
 	. path_to-SLIM-release-jlapps/environment.sh
##### 5.3.2 for csh-like shell add
 	source path_to-SLIM-release-jlapps/environment.csh
### 5.4 Preliminary testing of the environment
 Once configured, you can check if the SLIM_COMP , SLIM_JLAPPS, and
 SLIM_JLAPPS_RUNS  environments are set correctly using the commands
 below. At this point, unless you have appropriate version of Julia
 installed on your system by other means, this script will show the
 error indicating missing ‘julia’ executable or wrong Julia version
 (either to be ignored for now). 
#### 5.4.1 in bash-like shell execute
 	test_jl_env4slim.sh
#### 5.4.2 in csh-like shell execute
 	test_jl_env4slim.csh
## 6 INSTALLATION
 The installation relies on correctly set shell environment (see SHELL
 ENVIRONMENT section above) and should be executed in the terminal
 window only after that particular terminal session have the
 environment configured. Before starting/continuing with the
 installation, make sure that your environment was setup according to
 the instruction above.
 
 To run the installation, please, issue in the terminal window the
 commands listed in the following subsections:
### 6.1 Install Julia binaries
 If test_jl_env4slim.sh/csh returned the error about Julia while run
 before, get the proper Julia binaries 
 
 	get_Julia
### 6.2 Update/Install Python’s tools
 This step will require write privileges to SLIM-release-comp (if
 installed) and should be performed by the user that installed
 SLIM-release-comp. The way to complete this step depends on the chosen
 installation scenario:
#### 6.2.1 Quick personal SLIM-release-jlapps only installation with local
 Miniconda Python
 Run the following command in your terminal window:
 
 	get_Miniconda2
 
 Then run, depending on SHELL, either
 
 	 . environment.sh
 
 or
 
 	source environment.csh
#### 6.2.2 Complete user-owned installation
 Run the following command in your terminal window:
 
 	admin_update_pip
#### 6.2.3 Multi-user SLIM-release-comp installation
 Request that the owner of SLIM-release-comp runs the following
 commands in home directory of SLIM-release-comp installation:
 
 First, depending on SHELL, either
 
 	 . environment.sh
 
 or
 
 	source environment.csh
 
 Then
 
 	pip install -U pip setuptools
 
 Note, that the pip/setuptools update is not required often later on.
 It would need to be done again only if other updates complain about it
 being outdated.
#### 6.2.4 Rerun environment test
 After above is completed, you might rerun appropriate
 test_jl_env4slim.sh/csh. It should complete now without any error.
### 6.3 Install Python packages
 Run the following command in your terminal window:
 
 	install_pyPKGs
### 6.4 Install Julia packages
 Run the following command in your terminal window:
 
 	install_jlPKGs
### 6.5 The installation should be complete now
 If you encounter any problems with the steps above, please, contact us
 using information provide below.
 
 Note that you should repeat the install_* steps above after every pull
 from SLIM-release-jlapps repository, as the dependencies on 3-rd party
 packages might expand.
## 7 SUPPORT
 You may contact SLIM's developers of SINBAD software via issue tracker for this repository. We do not have resources to acctively support public version of our software. However, we will try to answert the questions as much as possible.
