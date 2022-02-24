#!/bin/bash

# Create the folder
rm -r yorp_test 2> /dev/null
mkdir yorp_test
# Move into the folder
cd yorp_test
# Create iput/output folders
mkdir input
mkdir output
# Symbolic links to the binary files
ln -s ../../bin/mercury6_yorp 
ln -s ../../bin/element6
ln -s ../../bin/close6
# Take YORP f,g files
cd input
cp ../../../dat/yorp_f.txt .
cp ../../../dat/yorp_g.txt . 
cp ../../../dat/yorp_test_files/input/*.in . 
# Take integration input files
cd ..
cp ../../dat/yorp_test_files/*.in .
cp ../../dat/yorp_test_files/clean.sh .
# Give execution permission to the cleaning script
chmod +x clean.sh
cd ..
