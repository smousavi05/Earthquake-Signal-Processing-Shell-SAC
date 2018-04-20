#!/bin/bash

echo "###################################  2addeventff.x   ##########################################"
echo "#################     adding the event information to the sac headers    ######################"
echo "###############################################################################################"

for ev in ` awk '{ print $1}' evfullist.dat`; do
echo $ev

evd=`grep "$ev" evfullist.dat` 
echo $evd

cd $ev
cd CNDC

echo "rh *.SAC" > addev.$ev.macro
echo $evd | awk -F" " '{printf( "%s "," ch EVLA "$8" EVLO "$9" EVDP "$10" MAG "$12);}' >> addev.$ev.macro

ls *.SAC >> saclist.dat
jul=`head -1 saclist.dat | awk 'BEGIN{FS="."}{print $2}'`

echo " " | awk '{printf(" \n");}'  >> addev.$ev.macro

echo $evd $jul | awk -F" " -v j="$jul" '{printf( "%s "," ch O GMT "$2" "j" "$5" "$6" "$7" "000);}' >> addev.$ev.macro
echo " " | awk '{printf(" \n");}'  >> addev.$ev.macro
echo "wh" >> addev.$ev.macro
echo " " | awk '{printf(" \n");}'  >> addev.$ev.macro
echo "q" >> addev.$ev.macro

sac addev.$ev.macro

rm addev.$ev.macro
cd ../../
echo "$ev   done with adding EVLA EVLO DIST " >> addevResult.dat
done
