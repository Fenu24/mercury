#bin/bash
./clean.sh

./mercury6
rm *.tmp
./element6
sed -i '1,4d' *.aei
mv element.out *.aei kepOut
./close6
mv *.clo closeOut 

