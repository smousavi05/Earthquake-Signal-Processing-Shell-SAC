#!/bin/sh
echo "#######################################  5snrff.x  ##############################################"
echo "###################      Auto Quality checking and Calculating SNR         ######################"
echo "#################################################################################################"

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

ls *.dsp | awk -F"." '{print $2}' | sort | uniq -c > stn.dat
         
echo "Record Quality: " > qualityA.dat
echo "H - High Quality" >> qualityA.dat
echo "L - Low Quality" >> qualityA.dat
echo "station comment SNR" >> qualityA.dat

k=` awk 'END{ print NR}' stn.dat`
echo "Number of Stations:"$k
echo -------------------------
for stn in ` awk '{ print $2}' stn.dat`; do
arr=(` ls *.dsp | grep "$stn"`) 
echo ${arr[*]}

echo "r ${arr[0]} ${arr[1]} ${arr[2]}" > 3.1.macro.mac
echo "lh OMARKER DIST" >> 3.1.macro.mac
echo "q" >> 3.1.macro.mac
sac 3.1.macro.mac > o.dis.lh

echo "r ${arr[0]}" > rddisaz.macro
echo "lh KSTNM AZ BAZ GCARC " >> rddisaz.macro
echo "q" >> rddisaz.macro

sac rddisaz.macro | grep "KSTNM" | awk '{printf( "%s", $3" "); }' >> azdistlist.txt 
sac rddisaz.macro | grep "AZ" | awk '{printf( "%s", $3" "); }' >> azdistlist.txt
sac rddisaz.macro | grep "BAZ" | awk '{printf( "%s", $3" "); }' >> azdistlist.txt
echo " " | awk '{printf(" \n");}' >> azdistlist.txt

origin=`sed -n '9p' o.dis.lh | awk -F "=" '{print $2}'`
dist=`sed -n '10p' o.dis.lh | awk -F "=" '{print $2}'`


o=`echo ${origin} | sed 's/[eE]+*/*10^/g' | bc -l`
d=`echo ${dist} | sed 's/[eE]+*/*10^/g' | bc -l`
echo "origin time: "$o 
echo "distance: "$d

t1=$(echo "$d/7.7"+"$o" | bc -l)
t2=$(echo "$d/6.7"+"$o" | bc -l)
t3=$(echo "$d/3.6"+"$o" | bc -l)
t4=$(echo "$d/3"+"$o" | bc -l)

echo $t1
echo $t2 
echo $t3
echo $t4

echo "r ${arr[0]} ${arr[1]} ${arr[2]}" > 3.2.macro.mac
echo "sync" >> 3.2.macro.mac
echo "MTW $t1 $t2 " >> 3.2.macro.mac
echo "RMS to user1 " >> 3.2.macro.mac
echo "MTW $t3 $t4 " >> 3.2.macro.mac
echo "RMS to user2 " >> 3.2.macro.mac
echo "lh user1 user2 " >> 3.2.macro.mac
echo "q" >> 3.2.macro.mac
sac 3.2.macro.mac > u1.u2.lh

st=` echo ${arr[0]} | awk 'BEGIN{FS="."}{ print $2}'`
cm=` echo ${arr[0]} | awk 'BEGIN{FS="."}{ print $3}'`
echo $cm
echo $st
st1=` echo ${arr[1]} | awk 'BEGIN{FS="."}{ print $2}'`
cm1=` echo ${arr[1]} | awk 'BEGIN{FS="."}{ print $3}'`
echo $cm1
echo $st1
st2=` echo ${arr[2]} | awk 'BEGIN{FS="."}{ print $2}'`
cm2=` echo ${arr[2]} | awk 'BEGIN{FS="."}{ print $3}'`
echo $cm2
echo $st2

if [[ $(echo "if ($dist <= 100) 1 else 0" | bc) -eq 1]]; then
echo "too close "
rm ../[D]??/*$st*

us01=` sed -n '9p' u1.u2.lh | awk -F "=" '{print $2}'`
us02=` sed -n '10p' u1.u2.lh | awk -F "=" '{print $2}'`

u01=`echo ${us01} | sed 's/[eE]+*/*10^/g' | bc -l`
u02=`echo ${us02} | sed 's/[eE]+*/*10^/g' | bc -l`

echo $u01 
echo $u02

us11=`sed -n '15p' u1.u2.lh | awk -F "=" '{print $2}'`
us12=`sed -n '16p' u1.u2.lh | awk -F "=" '{print $2}'`
 
u11=`echo ${us11} | sed 's/[eE]+*/*10^/g' | bc -l`
u12=`echo ${us12} | sed 's/[eE]+*/*10^/g' | bc -l`

echo $u11 
echo $u12

us21=`sed -n '21p' u1.u2.lh | awk -F "=" '{print $2}'`
us22=`sed -n '22p' u1.u2.lh | awk -F "=" '{print $2}'`

u21=`echo ${us21} | sed 's/[eE]+*/*10^/g' | bc -l`
u22=`echo ${us22} | sed 's/[eE]+*/*10^/g' | bc -l`

echo $u21 
echo $u22

snr0=$(echo "$u02/$u01" | bc -l)
snr1=$(echo "$u12/$u11" | bc -l)
snr2=$(echo "$u22/$u21" | bc -l)

if [[ $(echo "if ($snr0 >= 1.5) 1 else 0" | bc) -eq 1 ]]; then
echo " CN.$st.$cm   H  $snr0" >> qualityA.dat
else 
echo " CN.$st.$cm   L $snr0 " >> qualityA.dat
fi 

if [[ $(echo "if ($snr1 >= 1.5) 1 else 0" | bc) -eq 1 ]]; then
echo " CN.$st1.$cm1   H $snr1" >> qualityA.dat
else 
echo " CN.$st1.$cm1   L $snr1" >> qualityA.dat
fi 

if [[ $(echo "if ($snr2 >= 1.5) 1 else 0" | bc) -eq 1 ]]; then
echo " CN.$st2.$cm2   H $snr2" >> qualityA.dat
else 
echo " CN.$st2.$cm2   L $snr2" >> qualityA.dat

fi 

if [[ $(echo "if ($snr0 >= 1.5) 1 else 0" | bc) -eq 0 && $(echo "if ($snr1 >= 1.5) 1 else 0" | bc) -eq 0 ]]; then
echo "oooof"
#rm ../[D,A,V]??/*$st1*

elif [[ $(echo "if ($snr0 >= 1.5) 1 else 0" | bc) -eq 0 && $(echo "if ($snr2 >= 1.5) 1 else 0" | bc) -eq 0 ]]; then
echo "oooof"
#rm ../[D,A,V]??/*$st1*

elif [[ $(echo "if ($snr1 >= 1.5) 1 else 0" | bc) -eq 0 && $(echo "if ($snr2 >= 1.5) 1 else 0" | bc) -eq 0 ]]; then
echo "oooof"
#rm ../[D,A,V]??/*$st1*

fi

let k=$(($k-1))
echo " Remaining Stations:"$k

tail -"$k" 3stnam.dat > 3.2temp
mv 3.2temp 3stnam.dat

done 

echo " r *.??Z.dsp" > plot.mac
echo " map topo off stan on file stationPlot.ps plotstation on mapscale on plotlegend on " >> plot.mac 
echo " q" >> plot.mac
sac plot.mac

mv stationPlot.ps ../../.
mv qualityA.dat ../../.

#rm -f plot.mac
rm -f saclist.dat
rm -f stnam.d
rm -f 3stnam.dat
rm -f 3.1.macro.mac
rm -f o.dis.lh
rm -f 3.2.macro.mac
rm -f u1.u2.lh
rm -f 3.2temp
rm -f stn.dat
rm -r -f rddisaz.macro

cd ..

cd ../../
done
