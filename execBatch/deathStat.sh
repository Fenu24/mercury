#/bin/bash


grep "collided with" infoAll.txt > sunColl.txt
grep "was hit by" infoAll.txt > plaColl.txt
grep "ejected" infoAll.txt > ejected.txt

grep "MERCURY" plaColl.txt > merColl.txt
grep "VENUS"   plaColl.txt > venColl.txt
grep "EARTH"   plaColl.txt > earColl.txt
grep "MARS"    plaColl.txt > marColl.txt
grep "JUPITER" plaColl.txt > jupColl.txt
grep "SATURN"  plaColl.txt > satColl.txt
grep "URANUS"  plaColl.txt > uraColl.txt
grep "NEPTUNE" plaColl.txt > nepColl.txt

n_sunColl=$(wc -l < sunColl.txt)
n_plaColl=$(wc -l < plaColl.txt)
n_merColl=$(wc -l < merColl.txt)
n_venColl=$(wc -l < venColl.txt)
n_earColl=$(wc -l < earColl.txt)
n_marColl=$(wc -l < marColl.txt)
n_jupColl=$(wc -l < jupColl.txt)
n_satColl=$(wc -l < satColl.txt)
n_uraColl=$(wc -l < uraColl.txt)
n_nepColl=$(wc -l < nepColl.txt)
n_ejected=$(wc -l < ejected.txt)

n_tot=$(wc -l < infoAll.txt)

rm stat.txt 2> /dev/null

echo "n. of asteroids that reached the sink: $n_tot"  >> stat.txt
echo "---------------------------------------------" >> stat.txt
echo "n. ejected      : $n_ejected" >> stat.txt
echo "n. coll Sun     : $n_sunColl" >> stat.txt
echo "n. coll Mercury : $n_merColl" >> stat.txt
echo "n. coll Venus   : $n_venColl" >> stat.txt
echo "n. coll Earth   : $n_earColl" >> stat.txt
echo "n. coll Mars    : $n_marColl" >> stat.txt
echo "n. coll Jupiter : $n_jupColl" >> stat.txt
echo "n. coll Saturn  : $n_satColl" >> stat.txt
echo "n. coll Uranus  : $n_uraColl" >> stat.txt
echo "n. coll Neptune : $n_nepColl" >> stat.txt
echo "---------------------------------------------" >> stat.txt
