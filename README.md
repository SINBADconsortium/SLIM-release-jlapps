# Public legacy release of Julia-software repository for SLIM software release to SINBAD consortium
## 1 DESCRIPTION
 This is the repository for SLIM's software release, written in Julia
 language, for SINBAD consortium members. The release contains our
 applications and tools to install 3-rd party packages necessary to
 demonstrate and use algorithms developed by SLIM's researchers.
 
 SLIM's software release is organized in two repositories:
### 1.1 Repository SLIM-release-jlapps - this repository
 Repository at [SLIM-release-jlapps]
 (https://github.com/SINBADconsortium/SLIM-release-jlapps) contains
 core of SLIM's software, i.e. all applications. The necessary
 additional Python and Julia packages are added via installation steps.
 The software in this repository requires prior installation of
 SLIM-release-comp listed below.
 
 Note that each user must have a private copy of SLIM-release-jlapps in
 order to to run any applications, since an application is configured
 to look for data and create directories inside of application's
 directory. See INSTALLATION file for possible installation strategies.
### 1.2 Repository SLIM-release-comp
 Repository at [SLIM-release-comp]
 (https://github.com/SINBADconsortium/SLIM-release-comp) contains extra
 3rd-part software. The installation of software from this repository
 may be shared by multiple users and require lengthy installation. See
 INSTALLATION file for possible installation strategies.
## 2 COPYRIGHT
 You may use this code only under the conditions and terms of the
 license contained in the file LICENSE provided with this source code.
 If you do not agree to these terms you may not use this software.
## 3 PREREQUISITES
 Installing and using software in this repository requires network
 access.
 
 Currently it is advisable, but not yet necessary, to do prior
 installation of software tools from [SLIM-release-comp]
 (https://github.com/SINBADconsortium/SLIM-release-comp). Follow the
 instructions in INSTALLATION file of SLIM-release-comp before you
 install and use software from this repository. If you decide to
 postpone installation of [SLIM-release-comp], make sure the satisfy
 Python requirements as per INSTALLATION file in this repository.
 
 Note, that the successful installation of this software depends to
 large extend on the software libraries installed on your system.
 Although we provide the most important components via
 SLIM-release-comp, we cannot possible provide all software libraries
 that might be required. Please, do not hesitate to contact us if you
 encounter the problems during installation. We will be happy to assist
 you and identify potential problems. However, in some cases you will
 need help for your IT support to add relevant software libraries to
 your system.
## 4 INSTALLATION
 Note, that installation of software in this repository requires
 network access. Follow the instructions in the INSTALLATION file in
 this repository to install core of SLIM's software and create files
 necessary to configure your environment. If you encounter any problems
 during the installation, please, let us know. See SUPPORT section at
 the end for contact information.
## 5 RUNNING APPLICATIONS
 Please, see the specific instructions that are included in the README
 file in each application's directories. The application directories
 are organized by topics and are located inside of SLIM-release-jlapps
 directory. See LIST OF APPLICATIONS section below in this README for
 the current list of applications.
 
 Note, that you might need to download the data before running an
 application. The relevant instructions can be found in application's
 README file.
## 6 DOCUMENTATION
 For the information about SLIM's software applications, please, check
 the README files included with each application. Especially, check the
 README files and the applications to see how to execute and customize
 the applications to change parameters and/or use them with other input
 data. On-line documentation  for all applications can be found at
 [slim.gatech.edu](https://slim.gatech.edu/software/sinbad/documentation).
## 7 LIST OF APPLICATIONS
 The SLIM's software is divided into topic-oriented directories with
 applications in their sub-directories. Those applications demonstrate
 how to use our software.
### 7.1 Imaging/TimeDomain
 Time-domain seismic imaging
### 7.2 Modeling/TimeDomain
 Time-domain seismic modeling
### 7.3 WaveformInversion/TimeDomain
 Time-domain full-waveform inversion (2D & 3D subfolders)
## 8 SUPPORT
 You may contact SLIM's developers of SINBAD software via issue tracker for this repository. We do not have resources to actively support public version of our software. However, we will try to answer the questions as much as possible.
