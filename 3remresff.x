#!/bin/sh

echo  "##################################### 3remresff.x #######################################"
echo  "####################       removing the instrument responce     #########################"
echo  "#########################################################################################"

for ev in ` awk '{ print $1}' evfullist2.dat`; do
echo $ev

evd=`grep "$ev" evfullist2.dat` 

echo $evd

cd $ev

mkdir Icorrf
mkdir Icorrf/Dsp 
#mkdir Icorrf/Vel 
#mkdir Icorrf/Acc

rm -f Icorrf/Dsp/* 
rm -f Icorrf/Vel/*
rm -f Icorrf/Acc/*

cd CNDC

rm -f -r resrem.mac


ls *.SAC > saclist4.dat
awk -F"." '{print $2}' saclist4.dat | sort -u | uniq -u > stnam4.dat
cp stnam4.dat stnam4.2.dat


k=` awk 'END{ print NR}' stnam4.2.dat`
echo "Number of Stations:"$k
echo -------------------------

for stn in ` awk '{ print $1}' stnam4.2.dat`; do

arr=(` ls *.SAC | grep "$stn"`) 
n=${#arr[*]}

echo ${arr[0]}

s=` echo ${arr[0]} | awk 'BEGIN{FS="."}{ print $2}'`
c=` echo ${arr[0]} | awk 'BEGIN{FS="."}{ print $3}'`

r="RESP.CN."$s".."$c
echo $r

echo "r ${arr[0]} " > 6macro.mac
echo "lh DELTA" >> 6macro.mac
echo "q " >> 6macro.mac
sac 6macro.mac > del.lh

del0=`sed -n '9p' del.lh | awk -F "=" '{print $2}'`
d0=`echo ${del0} | sed 's/[eE]+*/*10^/g' | bc -l`
echo "$s $c delta: "$d0 >> delta.dat

FHH=`echo $d0 | awk '{print 0.50/$1}' `
FHL=`echo $d0 | awk '{print 0.25/$1}' `

echo "FHH" $FHH
echo "FHL" $FHL

echo "r ${arr[0]} " >> resrem.mac
echo "rmean " >> resrem.mac
echo "rtrend " >> resrem.mac
echo "taper " >> resrem.mac
echo "TRANSFER FROM EVALRESP FNAME $r TO NONE FREQLIM 0.95 0.98 17.8 18.5 PREW 6" >> resrem.mac
echo "DIV 1.0e9" >> resrem.mac
echo "w ../Icorrf/Dsp/CN."$s"."$c".dsp" >> resrem.mac

#echo "r ${arr[0]} " >> resrem.mac
#echo "rmean " >> resrem.mac
#echo "rtrend " >> resrem.mac
#echo "taper t c w .02 " >> resrem.mac
#echo "TRANSFER FROM EVALRESP FNAME $r TO VEL FREQLIM 0.49 0.52 15 17 PREW 6" >> resrem.mac
#echo "DIV 1.0e9" >> resrem.mac
#echo "w ../Icorrf/Vel/CN."$s"."$c".vel" >> resrem.mac

#echo "r ${arr[0]} " >> resrem.mac
#echo "rmean " >> resrem.mac
#echo "rtrend " >> resrem.mac
#echo "taper t c w .02 " >> resrem.mac
#echo "TRANSFER FROM EVALRESP FNAME $r TO ACC FREQLIM 0.4 0.6 15 17 PREW 4" >> resrem.mac
#echo "DIV 1.0e9" >> resrem.mac
#echo "w ../Icorrf/Acc/CN."$s"."$c".acc" >> resrem.mac

echo ${arr[1]}
s1=` echo ${arr[1]} | awk 'BEGIN{FS="."}{ print $2}'`
c1=` echo ${arr[1]} | awk 'BEGIN{FS="."}{ print $3}'`
r1="RESP.CN."$s1".."$c1
echo $r1

echo "r ${arr[1]} " > 6macro.mac
echo "lh DELTA" >> 6macro.mac
echo "q " >> 6macro.mac
sac 6macro.mac > del.lh

del1=`sed -n '9p' del.lh | awk -F "=" '{print $2}'`
d1=`echo ${del1} | sed 's/[eE]+*/*10^/g' | bc -l`
echo "$s1 $c1 delta: "$d1 >> delta.dat

FHH=`echo $d1 | awk '{print 0.50/$1}' `
FHL=`echo $d1 | awk '{print 0.25/$1}' `

echo "FHH" $FHH
echo "FHL" $FHL

echo "r ${arr[1]} " >> resrem.mac
echo "rmean " >> resrem.mac
echo "rtrend " >> resrem.mac
echo "taper t c w .02 " >> resrem.mac
echo "TRANSFER FROM EVALRESP FNAME $r1 TO NONE FREQLIM 1.49 1.5 17.5 18.5 PREW 6" >> resrem.mac
#echo "DIV 1.0e9" >> resrem.mac
echo "w ../Icorrf/Dsp/CN."$s1"."$c1".dsp" >> resrem.mac

#echo "r ${arr[1]} " >> resrem.mac
#echo "rmean " >> resrem.mac
#echo "rtrend " >> resrem.mac
#echo "taper t c w .02 " >> resrem.mac
#echo "TRANSFER FROM EVALRESP FNAME $r1 TO VEL FREQLIM 0.49 0.52 15 17 PREW 6" >> resrem.mac
#echo "DIV 1.0e9" >> resrem.mac
#echo "w ../Icorrf/Vel/CN."$s1"."$c1".vel" >> resrem.mac

#echo "r ${arr[1]} " >> resrem.mac
#echo "rmean " >> resrem.mac
#echo "rtrend " >> resrem.mac
#echo "taper t c w .02 " >> resrem.mac
#echo "TRANSFER FROM EVALRESP FNAME $r1 TO ACC FREQLIM 0.4 0.6 15 17 PREW 4" >> resrem.mac
#echo "DIV 1.0e9" >> resrem.mac
#echo "w ../Icorrf/Acc/CN."$s1"."$c1".acc" >> resrem.mac

echo ${arr[2]}
s2=` echo ${arr[2]} | awk 'BEGIN{FS="."}{ print $2}'`
c2=` echo ${arr[2]} | awk 'BEGIN{FS="."}{ print $3}'`
r2="RESP.CN."$s2".."$c2
echo $r2

echo "r ${arr[2]} " > 6macro.mac
echo "lh DELTA" >> 6macro.mac
echo "q " >> 6macro.mac
sac 6macro.mac > del.lh

del2=`sed -n '9p' del.lh | awk -F "=" '{print $2}'`
d2=`echo ${del2} | sed 's/[eE]+*/*10^/g' | bc -l`

echo "$s2 $c2 delta: "$d2 >> delta.dat


FHH=`echo $d2 | awk '{print 0.50/$1}' `
FHL=`echo $d2 | awk '{print 0.25/$1}' `

echo "FHH" $FHH
echo "FHL" $FHL

echo "r ${arr[2]} " >> resrem.mac
echo "rmean " >> resrem.mac
echo "rtrend " >> resrem.mac
echo "taper t c w .02 " >> resrem.mac
echo "TRANSFER FROM EVALRESP FNAME $r2 TO NONE FREQLIM 1.49 1.5 17.5 18.5 PREW 6" >> resrem.mac
#echo "DIV 1.0e9" >> resrem.mac
echo "w ../Icorrf/Dsp/CN."$s2"."$c2".dsp" >> resrem.mac

#echo "r ${arr[2]} " >> resrem.mac
#echo "rmean " >> resrem.mac
#echo "rtrend " >> resrem.mac
#echo "taper t c w .02 " >> resrem.mac
#echo "TRANSFER FROM EVALRESP FNAME $r2 TO VEL FREQLIM 0.49 0.52 15 17 PREW 6" >> resrem.mac
#echo "DIV 1.0e9" >> resrem.mac
#echo "w ../Icorrf/Vel/CN."$s2"."$c2".vel" >> resrem.mac

#echo "r ${arr[2]} " >> resrem.mac
#echo "rmean " >> resrem.mac
#echo "rtrend " >> resrem.mac
#echo "taper t c w .02 " >> resrem.mac
#echo "TRANSFER FROM EVALRESP FNAME $r2 TO ACC FREQLIM 0.4 0.6 15 17 PREW 4" >> resrem.mac
#echo "DIV 1.0e9" >> resrem.mac
#echo "w ../Icorrf/Acc/CN."$s2"."$c2".dsp" >> resrem.mac

let k=$(($k-1))
echo " Remaining Stations:"$k

tail -"$k" stnam4.2.dat > 4.2temp
mv 4.2temp stnam4.2.dat
done 
echo "q" >> resrem.mac

sac resrem.mac
rm -f stn_3c.id
rm saclist4.dat
rm -f stnam4.2.dat
rm -f stnam4.dat
rm -f 4.2temp
rm -f -r 6macro.mac
rm -f del.lh
rm -f -r resrem.mac
rm -f tem

cd ../../

done

