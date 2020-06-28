#/bin/bash
n_batch=20
i=1
while [ $i -le $n_batch ]
do
   rm -rf $i 2> /dev/null
   i=$[$i+1]
done
