# Manual for the augmented MERCURY integrator


This software is an augmented version of the MERCURY integrator, that was  originally developed by John E. Chambers. The new features included in this package are specifically designed for the propagation of small solar system objects, i.e. asteroids.

More specifically, the Yarkovsky effect is added to the gravitational vector field, and the spin-axis evolution due to the YORP effect is integrated together with the orbital dynamics. Technical details of the equations and of the implementation can be found in the paper

" ", M. Fenucci and B. Novakovic, Serbian Astronomical Journal

If you publish results using this version of the integrator, please reference the package using the above paper. 

In this readme you can find instructions on how to use the additional routines provided in this version of the integrator. To prepare the initial conditions for planets and small objects, please refer to the original manual written by John E. Chambers. 


## Authors 
- [Marco Fenucci](http://adams.dm.unipi.it/~fenucci/index.html), Department of Astronomy, Faculty of Mathematics, University of Belgrade (<marco_fenucci@matf.bg.ac.rs>) 
- [Bojan Novaković](http://poincare.matf.bg.ac.rs/~bojan/index_e.html), Department of Astronomy, Faculty of Mathematics, University of Belgrade (<bojan@matf.bg.ac.rs>) 


## New driver and compilation

The modified version of the MERCURY integrator contains a new driver to perform integrations called

 >  mercury6_2_yorp.for

This is the integration program, and it can be used to propagate numerically the dynamics of small solar system objects under the combined influence of the Yarkovsky/YORP effects. This program produces the same output files produced by the standard version of the MERCURY integrator, and additional files containing the spin-axis dynamics of the small bodies on request.

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

   and the executable binary files will be placed in the *bin* directory.


**NOTE 1.** For the compilation to work correclty, you need two hidden directories called *.mod* and *.obj*. Please be sure that these two folders are correctly contained on your local distribution.

**NOTE 2.** The Everhart's RA15 (Radau) integration method may not work properly, depending on the compiler used. From the tests we performed, we experienced problems with the GNU gfortran compiler (Version 9.3.0), while it was working correctly with the INTEL ifort compiler (Version 13.1.1)

## Files preparation

To run simulations that include the Yarkovsky/YORP effect in the model, some additional
input files are needed. 
   1. **yorp_f.txt**, **yorp_g.txt**: these are files containing a discretization of the mean torques shown in Fig. 1 of the reference paper. They are supposed to be placed in a subfolder called *input*. A copy of these files can be found in the *dat* folder of the distribution
   2. **yorp.in**: this is a file containing parameters for the integration of the spin-axis
     dynamics. This file is also supposed to be contained in a subfolder called *input*.
     Here you have to provide:
         - if you want to include the YORP effect in the model
         - if you want to use a stochastic YORP model (see reference paper)
         - if you want to choose the stepsize or if you want to use the automatic
            selection
         - in case you want to specify the stepsize, write the stepsize in years
         - if you want to enable the output for the spin-axis dynamics
         - the stepsize the the output
     An example of this input file can be found in the *test* folder
     
   3. **yarkovsky.in**: this file contains physical and thermal parameters of the asteroids.
     This file is supposed to be contained in the folder where the mercury integrator is
     run. Make sure that all the objects contained in the small.in file are also here.
     Here you have to provide, on each row:
         - the name of the asteroid
         - the density &rho; (kg/m^3)
         - the thermal conductivity K (W/m/K)
         - the heat capacity C (J/kg/K)
         - the diameter    D (meters)
         - the obliquity  &gamma; (degrees)
         - the rotation period  P (hours)
         - the absorption coefficient &alpha; (usually set to 1)
         - the emissivity &epsilon; (usually set to 1)

**NOTE 1.** When writing real numbers, please make sure they are written with at least a decimal number, or by using the d0 FORTRAN notation.

**NOTE 2.** To add the Yarkovsky effect to the model, make sure that the field *include user-defined force* in the original param.in input file for MERCURY is set to *yes*.


## Run a simulation and output files

## Test runs

## Refereces
- *Mercury and OrbFit packages for numerical integration of planetary systems: implementations of the Yarkovsky and YORP effects*

