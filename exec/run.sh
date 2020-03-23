#bin/bash
./clean.sh
cp input/yarkovsky.in .
./mercury6

rm yarkovsky.in
rm *.tmp
./element6
sed -i '1,4d' *.aei
mv element.out *.aei kepOut
./close6
mv *.clo closeOut 

