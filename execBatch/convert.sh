#/bin/bash

i="1"

while [ $i -le 10 ]
do
   echo "run $i"
   cp element.in $i
   cd $i
   ./element6 2>/dev/null
   sed -i 1,4d *.aei
   rm MERCURY.aei VENUS.aei EARTHMOO.aei MARS.aei JUPITER.aei SATURN.aei URANUS.aei NEPTUNE.aei
   cd ..
   mv $i/*.aei kep
   i=$[$i+1]
done


