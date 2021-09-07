#bin/bash

function usage () {
   echo " Usage: run.sh"
   exit 1
}


function filesin() {
   echo "input/big.in"          > files.in
   echo "input/small.in"       >> files.in
   echo "input/param$1.in"     >> files.in
   echo "output$1/xv.out"      >> files.in
   echo "output$1/ce.out"      >> files.in
   echo "output$1/info.out"    >> files.in
   echo "output$1/big.dmp"     >> files.in
   echo "output$1/small.dmp"   >> files.in
   echo "output$1/param.dmp"   >> files.in
   echo "output$1/restart.dmp" >> files.in
}

function elementin() {
echo ")O+_06 element  (WARNING: Do not delete this line!!)"                             > element.in
echo ") Lines beginning with ) are ignored."                                           >> element.in
echo ")---------------------------------------------------------------------"          >> element.in
echo " number of input files = 1"                                                      >> element.in
echo ")---------------------------------------------------------------------"          >> element.in
echo ") List the input files, one per line"                                            >> element.in
echo " output$1/xv.out"                                                                >> element.in
echo ")---------------------------------------------------------------------"          >> element.in
echo " type of elements (central body, barycentric, Jacobi) = central"                 >> element.in
echo " minimum interval between outputs (days) = 1.0"                             >> element.in
echo " express time in days or years = years"                                          >> element.in
echo " express time relative to integration start time = no"                          >> element.in
echo ")---------------------------------------------------------------------"          >> element.in
echo ") Output format? (e.g. a8.4 => semi-major axis with 8 digits & 4 dec. places)"   >> element.in
echo "   a8.5 e8.6 i8.4 n8.4 g8.4 l8.4"                                                >> element.in
echo ")---------------------------------------------------------------------"          >> element.in
echo ") Which bodies do you want? (List one per line or leave blank for all bodies)"   >> element.in
echo ")"                                                                               >> element.in
}


# Clean everything
./clean.sh

# Take the list of asteroid names
cat input/small.in | grep clo | awk '{print $1}' > astnames.txt

# Set the files.in for the forward integration
filesin "Forward"

# Run the forward integration
./mercury6
rm *.tmp

# Convert the output to Keplerian elements
elementin "Forward"
./element6

# Remove the header and move everything to OutputForward
sed -i '1,4d' *.aei
mv element.out *.aei outputForward


# Set the files.in for the backward integration
filesin "Backward"

# Run the backward integration
./mercury6
rm *.tmp

# Convert the output to Keplerian elements
elementin "Backward"
./element6

rm astnames.txt

# Remove the header and move everything to OutputBackward
# NOTE: we remove a line more, so that we cancel the initial 
# condition, which is already contained in the output file
# of the forward integration
sed -i '1,5d' *.aei
mv element.out *.aei outputBackward

# Take the names of the objects
ls outputForward | grep .aei > names.txt
input="names.txt"
while IFS= read -r obj
do
   # Gather the two integrations and save them in the 
   # kepOut folder
   tac outputBackward/$obj > kepOut/$obj
   cat outputForward/$obj >> kepOut/$obj
   rm outputBackward/$obj
   rm outputForward/$obj
done < "$input"
rm names.txt
