#!/bin/sh

echo  "##################################### 3remresff.x #######################################"
echo  "####################            Renaming the SAC files          #########################"
echo  "#########################################################################################"


for ev in ` awk '{ print $1}' evfullist2.dat`; do
echo $ev

cd $ev
mkdir Icorrf
mkdir Icorrf/Dsp 
mkdir Icorrf/Vel 
mkdir Icorrf/Acc

cd CNDC

t=`ls *.D.SAC | awk 'NR==1'`
cp $t ../Icorrf/

## rename the SAC filename to something like NET.STN.BH[ZNE].SAC
ls *.D.SAC | awk -F"." '{print $7,$8}' | sort | uniq -c | awk '{if ($1 == 3) print $2,$3}' | sort | uniq > stn_3c.id
ls `awk '{print "*"$1"."$2".*SAC"}' stn_3c.id` | awk -F"." '{print "mv "$0,$7"."$8"."$10"."$12}' | sh

#rm -f stn_3c.id

cd ../../

done

