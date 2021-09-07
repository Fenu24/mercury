#!/bin/bash

usage () {
	echo "Usage: config [options] <configuration>"
	echo "       where one of the following options must be selected: "
	echo "          -d  (debug)"
	echo "          -O  (optimized)"
	echo "       and <configuration> is one of the following:"
        echo "          intel   (Intel Fortran95 compiler vers. 8 and later)"
        echo "          gfortran (GNU F95 compiler) requires gcc 4.1 and later "
	exit 1
}

if [ $# -lt 1 ]; then
	usage
fi

# Compilation options (debug/optimize)
opt="d"
if [ "$1" = "-d" ]; then
	opt="d"
	shift
elif [ "$1" = "-p" ]; then
	opt="p"
	shift
elif [ "$1" = "-O" ]; then
	opt="O"
	shift
fi
if [ $# -ne 1 ]; then
	usage
fi

# Configuration
conf=$1

# Remove configuration files
rm make.flags

# Create new configuration files
touch make.flags

if [ $conf = "intel" ]; then
  echo "FORTRAN=ifort" >> make.flags
  if [ $opt = "d" ]; then
    echo "FFLAGS=-module .mod -warn nousage -g -CB -shared-intel -mcmodel=medium -traceback -fp-model fast -save -assume byterecl" >> make.flags
  else
    echo "FFLAGS=-g -O2 -static -module .mod" >> make.flags
  fi
fi

if [ $conf = "gfortran" ]; then
  echo "FORTRAN=gfortran" >> make.flags
  if [ $opt = "d" ]; then
    echo "FFLAGS=-J.mod -g -O0 -fbounds-check -pedantic -fbacktrace -fcheck=all" >> make.flags
  else
    echo "FFLAGS=-J.mod -g -O2 -static" >> make.flags
  fi
fi
