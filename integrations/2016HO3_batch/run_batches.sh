#bin/bash

function usage () {
   echo " Usage: run.sh <yarko drift modulo> <sign>"
   exit 1
}


function filesin() {
   echo "../input/big.in"       > files.in
   echo "../input/small$2.in"  >> files.in
   echo "../input/param$1.in"  >> files.in
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
echo " minimum interval between outputs (days) = 365.25d0"                             >> element.in
echo " express time in days or years = years"                                          >> element.in
echo " express time relative to integration start time = yes"                          >> element.in
echo ")---------------------------------------------------------------------"          >> element.in
echo ") Output format? (e.g. a8.4 => semi-major axis with 8 digits & 4 dec. places)"   >> element.in
echo "   a8.5 e8.6 i8.4 n8.4 g8.4 l8.4"                                                >> element.in
echo ")---------------------------------------------------------------------"          >> element.in
echo ") Which bodies do you want? (List one per line or leave blank for all bodies)"   >> element.in
echo ")"                                                                               >> element.in
}

if [ $# -lt 2 ]; then
   echo 'no Yarkovsky drift or direction supplied'
   usage
fi

# Clean and prepare for forward integration
n_batch=20
i=1
while [ $i -le $n_batch ]
do
   rm -rf $i 2> /dev/null
   mkdir $i
   cp message.in $i
   cd $i

   ln -s ../../../bin/close6
   ln -s ../../../bin/element6
   ln -s ../../../bin/mercury6

   mkdir kepOut
   mkdir outputForward
   filesin "Forward" $i

   # Take the list of asteroid names
   cat ../input/small$i.in | grep clo | awk '{print $1}' > astnames.txt

   # Create yarkovsky.in for the forward integration
   rm yarkovsky.in 2>/dev/null
   touch yarkovsky.in
   while IFS= read -r astNam; do
      if [ $2 == "+" ]; then
         echo "$astNam $1" >> yarkovsky.in
      else
         echo "$astNam -$1" >> yarkovsky.in
      fi
   done < astnames.txt
   cd ..
   i=$[$i+1]
done

# Run and convert the forward integration
# Run the jobs
usedproc=0
nproc=2
for (( j=1; j<$n_batch+1; j++)) do
   cd $j
   echo "run number " $j
   nohup ./mercury6 & 2>/dev/null
   let usedproc=usedproc+1
   if [ $usedproc -ge $nproc ]; then
     wait
     usedproc=0
   fi
  cd ..
done 
wait

# Convert the forward integration
for (( j=1; j<$n_batch+1; j++)) do
   cd $j 
   elementin "Forward"
   ./element6
   # Remove the header and move everything to OutputForward
   sed -i '1,4d' *.aei
   mv element.out *.aei outputForward
   cd ..
done


i=1
while [ $i -le $n_batch ]
do
   cd $i

   mkdir outputBackward
   filesin "Backward" $i

   # Take the list of asteroid names
   cat ../input/small$i.in | grep clo | awk '{print $1}' > astnames.txt

   # Create yarkovsky.in for the backward integration
   # NOTE: we have to change the sign for the backward propagation!
   rm yarkovsky.in 2>/dev/null
   touch yarkovsky.in
   while IFS= read -r astNam; do
      if [ $2 == "+" ]; then
         echo "$astNam -$1" >> yarkovsky.in
      else
         echo "$astNam $1" >> yarkovsky.in
      fi
   done < astnames.txt

   cd ..
   i=$[$i+1]
done

# Run and convert the backward integration
# Run the jobs
usedproc=0
nproc=2
for (( j=1; j<$n_batch+1; j++)) do
   cd $j
   echo "run number " $j
   nohup ./mercury6 & 2>/dev/null
   let usedproc=usedproc+1
   if [ $usedproc -ge $nproc ]; then
     wait
     usedproc=0
   fi
  cd ..
done 
wait

# Convert the forward integration
for (( j=1; j<$n_batch+1; j++)) do
   cd $j 
   elementin "Backward"
   ./element6
   # Remove the header and move everything to OutputForward
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

   cd ..
done
