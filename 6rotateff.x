#!/bin/sh

echo "######################################  6rotateff.x  #############################################"
echo "############################       Rotating final output       ###################################"
echo "##################################################################################################"

e=` awk 'END{ print NR}' evfullist2.dat`

for ev in ` awk '{ print $1}' evfullist2.dat`; do
echo $ev

cd $ev
cd Icorrf

#cd  Vel

#ls *.vel | awk -F"." '{print $1,$2}' | sort | uniq -c | awk '{if ($1 == 3) print $2,$3}' | sort | uniq > stn_3c.id

#ls *.vel> saclist5.dat
#awk -F"." '{print $2}' saclist5.dat | sort -u | uniq -u > stnam5.dat
#k=` awk 'END{ print NR}' stnam5.dat`
#echo -------------------------

#for stn in ` awk '{ print $1}' stnam5.dat`; do

#echo "r CN.$stn.??N.vel " > 5macro.mac
#echo "ch CMPAZ 0 CMPINC 90 " >> 5macro.mac
#echo "wh " >> 5macro.mac
#echo "r CN.$stn.??E.vel " >> 5macro.mac
#echo "ch CMPAZ 90 CMPINC 90 " >> 5macro.mac
#echo "wh " >> 5macro.mac
#echo "q " >> 5macro.mac

#sac 5macro.mac

#tail -"$k" stnam5.dat > 3.2temp
#mv 3.2temp stnam5.dat

#done

#saclst e f `awk '{print $1"."$2".?H[EN].vel"}' stn_3c.id` 
#saclst e f `awk '{print $1"."$2".?H[EN].vel"}' stn_3c.id` |\
#paste - - | awk '{if ($2> $4) print $4;else print $2}' > BH_EN_end_time.dat
#saclst b f `awk '{print $1"."$2".?H[EN].vel"}' stn_3c.id` |\
#paste - - | awk '{if ($2< $4) print $4;else print $2}' > BH_EN_start_time.dat
#paste -d" " stn_3c.id BH_EN_start_time.dat BH_EN_end_time.dat |\
#awk '{print "cut "$3,$4"\nr "$1"."$2".?H[EN].vel\nrmean\nrtrend\nrotate to GCP\nw "$1"."$2".HHR.vel "$1"."$2".HHT.vel"} END {print "q"}' | sac
#awk '{print "r "$1"."$2".*.vel\nrmean\nrtrend\nw over"} END {print "q"}' stn_3c.id | sac

#rm -f 3.2temp
#rm -f saclist5.dat
#rm -f stnam5.dat
#rm -f stn_3c.id
#rm -f BH_EN_end_time.dat
#rm -f BH_EN_start_time.dat
#rm -f -r 5macro.mac

#cd ..
#cd Acc

#ls *.acc | awk -F"." '{print $1,$2}' | sort | uniq -c | awk '{print $2,$3}' | sort | uniq > stn_3c.id

#ls *.acc> saclist5.dat
#awk -F"." '{print $2}' saclist5.dat | sort -u | uniq -u > stnam5.dat
#k=` awk 'END{ print NR}' stnam5.dat`
#echo -------------------------

#for stn in ` awk '{ print $1}' stnam5.dat`; do

#echo "r CN.$stn.??N.acc " > 5macro.mac
#echo "ch CMPAZ 0 CMPINC 90 " >> 5macro.mac
#echo "wh " >> 5macro.mac
#echo "r CN.$stn.??E.acc " >> 5macro.mac
#echo "ch CMPAZ 90 CMPINC 90 " >> 5macro.mac
#echo "wh " >> 5macro.mac
#echo "q " >> 5macro.mac

#sac 5macro.mac

#tail -"$k" stnam5.dat > 3.2temp
#mv 3.2temp stnam5.dat

#done

#saclst e f `awk '{print $1"."$2".?H[EN].acc"}' stn_3c.id` 
#saclst e f `awk '{print $1"."$2".?H[EN].acc"}' stn_3c.id` |\
#paste - - | awk '{if ($2> $4) print $4;else print $2}' > BH_EN_end_time.dat
#saclst b f `awk '{print $1"."$2".?H[EN].acc"}' stn_3c.id` |\
#paste - - | awk '{if ($2< $4) print $4;else print $2}' > BH_EN_start_time.dat
#paste -d" " stn_3c.id BH_EN_start_time.dat BH_EN_end_time.dat |\
#awk '{print "cut "$3,$4"\nr "$1"."$2".?H[EN].acc\nrmean\nrtrend\nrotate to GCP\nw "$1"."$2".HHR.acc "$1"."$2".HHT.acc"} END {print "q"}' | sac
#awk '{print "r "$1"."$2".*.acc\nrmean\nrtrend\nw over"} END {print "q"}' stn_3c.id | sac


#rm -f 3.2temp
#rm -f saclist5.dat
#rm -f stnam5.dat
#rm -f stn_3c.id
#rm -f BH_EN_end_time.dat
#rm -f BH_EN_start_time.dat
#rm -f -r 5macro.mac

#cd ..
cd Dsp

ls *.dsp | awk -F"." '{print $1,$2}' | sort | uniq -c | awk '{print $2,$3}' | sort | uniq > stn_3c.id

ls *.dsp> saclist5.dat
awk -F"." '{print $2}' saclist5.dat | sort -u | uniq -u > stnam5.dat
k=` awk 'END{ print NR}' stnam5.dat`
echo -------------------------

for stn in ` awk '{ print $1}' stnam5.dat`; do

echo "r CN.$stn.??N.dsp " > 5macro.mac
echo "ch CMPAZ 0 CMPINC 90 " >> 5macro.mac
echo "wh " >> 5macro.mac
echo "r CN.$stn.??E.dsp " >> 5macro.mac
echo "ch CMPAZ 90 CMPINC 90 " >> 5macro.mac
echo "wh " >> 5macro.mac
echo "q " >> 5macro.mac

sac 5macro.mac

tail -"$k" stnam5.dat > 3.2temp
mv 3.2temp stnam5.dat

done

saclst e f `awk '{print $1"."$2".?H[EN].dsp"}' stn_3c.id` 
saclst e f `awk '{print $1"."$2".?H[EN].dsp"}' stn_3c.id` |\
paste - - | awk '{if ($2> $4) print $4;else print $2}' > BH_EN_end_time.dat
saclst b f `awk '{print $1"."$2".?H[EN].dsp"}' stn_3c.id` |\
paste - - | awk '{if ($2< $4) print $4;else print $2}' > BH_EN_start_time.dat
paste -d" " stn_3c.id BH_EN_start_time.dat BH_EN_end_time.dat |\
awk '{print "cut "$3,$4"\nr "$1"."$2".?H[EN].dsp\nrmean\nrtrend\nrotate to GCP\nw "$1"."$2".HHR.dsp "$1"."$2".HHT.dsp"} END {print "q"}' | sac
awk '{print "r "$1"."$2".*.dsp\nrmean\nrtrend\nw over"} END {print "q"}' stn_3c.id | sac

rm -f 3.2temp
rm -f saclist5.dat
rm -f stnam5.dat
rm -f stn_3c.id
rm -f BH_EN_end_time.dat
rm -f BH_EN_start_time.dat
rm -f -r 5macro.mac

cd ../../../

tail -"$e" evfullist2.dat > 5temp
mv 5temp evfullist2.dat

done
rm -f 5temp

