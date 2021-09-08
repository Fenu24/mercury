
                  M A N U A L    F O R   T H E   A U G M E N T E D  
                  ================================================

                        M E R C U R Y   I N T E G R A T O R
                        ===================================

  =======================================================================================
||     AUTHORS: Marco Fenucci & Bojan Novakovic                                          ||
|| INSTITUTION: Department of Astronomy, Faculty of Mathematics, University of Belgrade  ||
||     VERSION: 1.0                                                                      ||
||        DATE: September 2021                                                           ||
||  REF. PAPER: "", M. Fenucci and B. Novakovic, Serbian Astronomical Journal            ||
  =======================================================================================

   C O N T E N T S
   ===============

   (1) Introduction

   (2) Compilation

   (3) File preparation

   (4) Run a simulation and output files

   (5) Test run

------------------------------------------------------------------------------

(1)  I N T R O D U C T I O N
     =======================

This software contains an augmented version of the MERCURY integrator, that was 
originally developed by John E. Chambers. The additional module yorp_module.f90 and the
additional subroutines wrote in the source code are specifically designed for the
propagation of small solar system objects, i.e. asteroids. In particular, the Yarkovsky
effect is added to the gravitational vector field through the mfo_user subroutine, and the
spin-axis evolution due to the YORP effect is integrated together with the orbital
integration. Technical details of the equations and of the implementation can be found in
the paper

" ", M. Fenucci and B. Novakovic, Serbian Astronomical Journal

If you publish results using this version of the integrator, please reference the package
using the above paper. In this manual you can find instructions on how to use the additional 
routines provided in this version of the integrator. To prepare the initial conditions for planets 
and small objects, please refer to the original manual written by John E. Chambers. 

N.B. The Everhart's RA15 (Radau) integration method may not work properly, depending on
===  the compiler used. From the tests we performed, we experienced problems with the GNU
     gfortran compiler (Version 9.3.0), while it was working correctly with the INTEL ifort 
     compiler (Version 13.1.1)

The modified version of the MERCURY integrator contains a driver to perform integrations:

   1) mercury6_2_yorp.for

   This is the integration programme, and it can be used to propagate numerically the
   dynamics of small solar system objects under the combined influence of the
   Yarkovsky/YORP effects. This program produces the same output files produced by the
   standard version of the MERCURY integrator, and additional files containing the
   spin-axis dynamics of the small bodies on request.

------------------------------------------------------------------------------

(2)  C O M P I L A T I O N  
     =====================

Before using the package for the first time, the code needs to be compiled. To facilitate
the user, the distribution comes with a configuration script and a Makefile that
automatically do the job. To compile the source code, please follow these steps
   
      i) Choose the compiler and the compilation options by running the config.sh script.
         By running the script without further options, you will receive an help message.
         The script permits to choose between two different compiler: 
            - GNU gfortran compiler
            - Intel ifort compiler
         An additional option defines the compilation flags, and the user can select the
         optimization flags. For instance, if you want to use the GNU gfortran, you can
         run the script as
            
            ./config.sh -O gfortran

         or, if you want to use the Intel compiler
            
            ./config.sh -O ifort

     ii) Run the Makefile to compile the source code. To this purpose, you can type

            make build

         and the binary executable files will be placed in the bin directory.

     N.B. For the compilation to work correclty, you need two hidden directories called
     ===  .mod and .obj Please be sure that these two folders are correctly contained on 
          your local distribution.

------------------------------------------------------------------------------

(3)  F I L E   P R E P A R A T I O N  
     ===============================

To run simulations that includes the Yarkovsky/YORP effect in the model, some additional
input files are needed. 
   
   - yorp_f.txt, yorp_g.txt : these are files containing a discretization of the mean
     torques shown in Fig. 1 of the reference paper. They are supposed to be placed in 
     a subfolder called "input". A copy of these files can be found in the "dat" folder 
     of the distribution

   - yorp.in : this is a file containing parameters for the integration of the spin-axis
     dynamics. This file is also supposed to be contained in a subfolder called "input".
     Here you have to provide:
         i) if you want to include the YORP effect in the model
        ii) if you want to use a stochastic YORP model (see reference paper)
       iii) if you want to choose the stepsize or if you want to use the automatic
            selection
        iv) in case you want to specify the stepsize, write the stepsize in years
         v) if you want to enable the output for the spin-axis dynamics
        vi) the stepsize the the output
     An example of this input file can be found in the test folder

   - yarkovsky.in : this file contains physical and thermal parameters of the asteroids.
     This file is supposed to be contained in the folder where the mercury integrator is
     run. Make sure that all the objects contained in the small.in file are also here.
     Here you have to provide, on each row:
            the name of the asteroid
            the density rho            (kg/m^3)
            the thermal conductivity K (SI units)
            the heat capacity C        (SI units)
            the diameter      D        (meters)
            the obliquity              (degrees)
            the rotation period        (hours)
            the absorption coefficient (usually set to 1)
            the emissivity             (usually set to 1)

N.B. When writing real numbers, please make sure they are written with at least a decimal
===  number, or by using the d0 FORTRAN notation 

N.B. To add the Yarkovsky effect to the model, make sure that the field "include user-defined force" 
===  in the original param.in input file for MERCURY is set to yes.

------------------------------------------------------------------------------

   (4) R U N   A   S I M U L A T I O N   A N D   O U T P U T   F I L E S
   =====================================================================
