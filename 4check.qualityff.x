#!/bin/sh

echo  "################################  4check.qualityff.x  ##################################"
echo  "##########################  final check & making qualityf.dat   ########################"
echo  "########################################################################################"

e=` awk 'END{ print NR}' evfullist2.dat`

for ev in ` awk '{ print $1}' evfullist2.dat`; do
echo -------------------------
echo " Number oof Events: "$e
echo -------------------------
echo "Event Name:"$ev
echo -------------------------
cd $ev
cd Icorrf
cd Dsp

ls *.dsp | awk -F"." '{print $1,$2}' | sort | uniq -c > ../stn.dat
cd ..                       

echo "Record Quality: " > qualityM.dat
echo "A - Good" >> qualityM.dat
echo "B - Bad, problem with component" >> qualityM.dat
echo "? - Accepted, but might have problem" >> qualityM.dat
echo "C - Clipped" >> qualityM.dat
echo "D - directivity" >> qualityM.dat
echo "N - radiation effect" >> qualityM.dat
echo "M - missing data in waveform" >> qualityM.dat
echo "O - Orientation missing" >> qualityM.dat
echo "S - spikes in data" >> qualityM.dat
echo "X - no data - in noise" >> qualityM.dat
echo "station comment" >> qualityM.dat

k=` awk 'END{ print NR}' stn.dat`
echo "Number of Stations:"$k
echo -------------------------
for stn in ` awk '{ print $3}' stn.dat`; do
echo $stn

echo "r [D]??/*$stn* " > 7macro.mac
echo "qdp off " >> 7macro.mac
echo "p1" >> 7macro.mac
sac 7macro.mac

echo ---------------------------------------
echo "A - Good" 
echo "B - Bad, problem with component" 
echo "? - Accepted, but might have problem" 
echo "C - Clipped" 
echo "D - directivity" 
echo "N - radiation effect" 
echo "M - missing data in waveform" 
echo "O - Orientation missing" 
echo "S - spikes in data" 
echo "X - no data - in noise" 

echo "x - delete" 
echo ----------------------------------------
echo what you think ?
read com
                  
echo "$stn      $com " >> qualityM.dat

if [ "$com" == "x" ]; 
then 
rm [A,D]??/*$stn*
fi 

let k=$(($k-1))
echo " Remaining Stations:"$k

tail -"$k" stn.dat > temp
mv temp stn.dat
read -p next
 
done 
mv qualityM.dat ..
rm -f stn.dat
rm -r -f 7macro.mac
rm -f temp

cd ../../
let e=$(($e-1))

tail -"$e" evfullist2.dat > 3.3temp
mv 3.3temp evfullist2.dat
read -p next
rm -f 3.3temp

done
