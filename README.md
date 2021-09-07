# Manual for the augment MERCURY integrator

## Authors 
- [Marco Fenucci](http://adams.dm.unipi.it/~fenucci/index.html), Department of Astronomy, Faculty of Mathematics, University of Belgrade (<marco_fenucci@matf.bg.ac.rs>) 
- [Bojan Novaković](http://poincare.matf.bg.ac.rs/~bojan/index_e.html), Department of Astronomy, Faculty of Mathematics, University of Belgrade (<bojan@matf.bg.ac.rs>) 


## Introduction

This software contains an augmented version of the MERCURY integrator, that was  originally developed by John E. Chambers. The additional module yorp_module.f90 and the additional subroutines wrote in the source code are specifically designed for the propagation of small solar system objects, i.e. asteroids. In particular, the Yarkovsky effect is added to the gravitational vector field through the mfo_user subroutine, and the spin-axis evolution due to the YORP effect is integrated together with the orbital integration. Technical details of the equations and of the implementation can be found in the paper

" ", M. Fenucci and B. Novakovic, Serbian Astronomical Journal

If you publish results using this version of the integrator, please reference the package using the above paper. In this manual you can find instructions on how to use the additional routines provided in this version of the integrator. To prepare the initial conditions for planets and small objects, please refer to the original manual written by John E. Chambers. 

**NOTE:** The Everhart's RA15 (Radau) integration method may not work properly, depending on the compiler used. From the tests we performed, we experienced problems with the GNU gfortran compiler (Version 9.3.0), while it was working correctly with the INTEL ifort compiler (Version 13.1.1)

The modified version of the MERCURY integrator contains a new driver to perform integrations called

 >  mercury6_2_yorp.for

This is the integration programme, and it can be used to propagate numerically the dynamics of small solar system objects under the combined influence of the Yarkovsky/YORP effects. This program produces the same output files produced by the standard version of the MERCURY integrator, and additional files containing the spin-axis dynamics of the small bodies on request.


## Compilation
Before using the package for the first time, the code needs to be compiled. To facilitate the user, the distribution comes with a configuration script and a Makefile that automatically do the job. To compile the source code, please follow these steps
1. Choose the compiler and the compilation options by running the config.sh script. By running the script without further options, you will receive an help message. The script permits to choose between two different compiler: 
            - GNU gfortran compiler
            - Intel ifort compiler
         An additional option defines the compilation flags, and the user can select the
         optimization flags. For instance, if you want to use the GNU gfortran compiler, you can
         run the script as
           
           ./config.sh -O gfortran
            
2. Run the Makefile to compile the source code. To this purpose, you can type

            make build

   and the binary executable files will be placed in the bin directory.


**NOTE:** For the compilation to work correclty, you need two hidden directories called .mod and .obj. Please be sure that these two folders are correctly contained on your local distribution.


## Files preparation

## Run a simulation and output files

## Test runs

## Refereces
- *Mercury and OrbFit packages for numerical integration of planetary systems: implementations of the Yarkovsky and YORP effects*

