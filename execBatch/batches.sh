#/bin/bash

astCat="ast3to1.cat"
# Remove header and apostrophes from astCat
sed '/!/d' $astCat | sed '1d' | sed s/\'//g > tmp.cat

i="1"

while [ $i -le 20 ]
do
   rm -rf $i 2>/dev/null
   mkdir $i
   if [ $i -le 10 ]
   then
      j=$[($i-1)*50+1]
      k=$[($i-1)*50+50]
   else
      j=$[($i-11)*50+20808]
      k=$[($i-11)*50+20808+50]
   fi
   # Take the 50 asteroids
   sed -n "$j,$k p" tmp.cat > batch.cat
   # Create small.in
   echo ")O+_06 Small-body initial data  (WARNING: Do not delete this line!!)" > small.in
   echo ") Lines beginning with \`)\' are ignored." >> small.in 
   echo ")---------------------------------------------------------------------" >> small.in
   echo " style (Cartesian, Asteroidal, Cometary) = Asteroidal" >> small.in
   echo ")--------------------------------------------d or D is not matter--0d0 is possible too--" >> small.in
   while IFS=" " read -r name t0 a e inc OmNod omega ell H x y ; do
      t0JD=$(echo $t0 '+ 2400000.5' | bc)
      echo "$name ep=$t0JD" >> small.in
      echo " $a $e $inc $omega $OmNod $ell 0.d0 0.d0 0.d0" | sed s/E/d/g >> small.in
   done < batch.cat 
   # prepare other input files for mercury
   mv small.in $i
   cp message.in $i
   cp element.in $i
   cd $i
   echo "../big.in"    > files.in
   echo "small.in"    >> files.in
   echo "../param.in" >> files.in
   echo "xv.out"      >> files.in
   echo "ce.out"      >> files.in
   echo "info.out"    >> files.in
   echo "big.dmp"     >> files.in
   echo "small.dmp"   >> files.in
   echo "param.dmp"   >> files.in
   echo "restart.dmp" >> files.in
   # links to the executables
   ln -s ../../bin/mercury6
   ln -s ../../bin/element6
   ln -s ../../bin/close6
   cd ..
   i=$[$i+1]
done
rm batch.cat tmp.cat

# Run the jobs
#usedproc=0
#nproc=5
#nrun=20
#for (( j=1; j<$nrun+1; j++)) do
#   cd $j
#   echo "run number " $j
#   nohup ./mercury6 & 2>/dev/null
#   let usedproc=usedproc+1
#   if [ $usedproc -ge $1 ]; then
#     wait
#     usedproc=0
#   fi
#   cd ..
#done 
#wait
