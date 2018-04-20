#!/bin/sh

################################################################################################ 
#      This script was written by Mostafa Mousavi for seismic data processing .
#      The script was primerelly written for CNDC data format of Canadian network. further uses
#      may need some modifications.  
#############
#  Mostafa Mousavi
#  Center for Earthquake Research and Information (CERI), 
#  University of Memphis, Memphis, TN.
#  smousavi@memphis.edu
#  04/01/2014 
################################################################################################
################################################################################################

#############   Renaming the seed files and making the directory for earthquake  ###############
################################################################################################
./1readseedff.x

#################     adding the event information to the sac headers    ########################
#################################################################################################

#cd newprocessing
#ln -sf ../2addeventff.x 2addeventff.x
#./2addeventff.x
# cd ..

##########################           Renaming the SAC files           ###########################
#################################################################################################
#cd newprocessing 
#cp evfullist.dat evfullist2.dat
#ln -sf ../3renam.x 3renam.x
#./3renam.x
#cd ..

##########################       removing the instrument responce     ###########################
#################################################################################################

#cd newprocessing 
#cp evfullist.dat evfullist2.dat
#ln -sf ../3remresff.x 3remresff.x
3./3remresff.x
#cd ..

#############################   final check & making qualityf.dat    ############################
#################################################################################################

#cd newprocessing 
#cp evfullist.dat evfullist2.dat
#ln -sf ../4check.qualityff.x 4check.qualityff.x
#./4check.qualityff.x
#cd ..

###################      Auto Quality checking and Calculating SNR         ######################
#################################################################################################

#cd newprocessing
#cp evfullist.dat evfullist2.dat
#ln -sf ../5snrff.x 5snrff.x
#./5snrff.x
#cd ..

############################       Rotating final output       ###################################
##################################################################################################

#cd newprocessing 
#cp evfullist.dat evfullist2.dat
#ln -sf ../6rotateff.x 6rotateff.x
#./6rotateff.x
#cd ..

########################        amplitute calculation       ######################################
##################################################################################################

#cd newprocessing 
#cp evfullist.dat evfullist2.dat
#ln -sf ../7ampmaker.x 7ampmaker.x
#./7ampmaker.x
#cd ..

########################        plotting              ############################################
##################################################################################################

#cd newprocessing 
#cp evfullist.dat evfullist2.dat
#ln -sf ../8plottingff.x 8plottingff.x
#./8plottingff.x
#cd ..

########################        Travel tim plot       ############################################
##################################################################################################

#cd newprocessing 
#cp evfullist.dat evfullist2.dat
#ln -sf ../9traveltimeff.x 9traveltimeff.x
#./9traveltimeff.x
#cd ..

########    renaming the original sac files andd rotating the horizontal components    ##########
#################################################################################################

#cd newprocessing 
#cp evfullist.dat evfullist2.dat
#ln -sf ../10sacrotate.x 10sacrotate.x
#./10sacrotate.x
#cd ..

#################       picking P and S arrivals  and making quality.dat     ####################
#################################################################################################

#cd newprocessing 
#cp evfullist.dat evfullist2.dat
#ln -sf ../11pspicking.x 11pspicking.x
#./11pspicking.x
#cd ..

#########################################  fft and noise    #####################################
#################################################################################################

#cd newprocessing 
#cp evfullist.dat evfullist2.dat
#ln -sf ../12fft.noise.x 12fft.noise.x
#./12fft.noise.x
#cd ..


################################################################################################
################################################################################################
################################################################################################

# echo "###################################  1readseedff.x   ##########################################"
# echo "#############  Renaming the seed files and making the directory for earthquake  ###############"
# echo "###############################################################################################"
# cp evfullist.dat newprocessing/.

# cd seedfiles 
# for i in $(ls *); do
# echo $i

# dy=`echo $i | awk 'BEGIN{FS="."}{print $1}'`
# hr=`echo $i | awk 'BEGIN{FS="."}{print $2}'`

# j=$dy.$hr.SEED
# echo $j 

# mv $i $j

# mkdir ../newprocessing/canada_$dy.$hr
# mkdir ../newprocessing/canada_$dy.$hr/CNDC
# mkdir ../newprocessing/canada_$dy.$hr/CNDC/seed.sac

# cp ../station.info ../newprocessing/canada_$dy.$hr/CNDC/seed.sac/.
# cp $dy.$hr.SEED ../newprocessing/canada_$dy.$hr/CNDC/seed.sac/.

# cd ../newprocessing/canada_$dy.$hr/CNDC/seed.sac

# rdseed -f $dy.$hr.SEED -R -d -o 1

# for st in `awk '{print $1}' station.info`; do 
# mv ????.*.??.??.??.????.CN.$st..H??.?.SAC ../.
# mv ????.*.??.??.??.????.CN.$st..B??.?.SAC ../.
# mv RESP.CN.$st..??? ../.
# done

# cd ../

# rm -r -f seed.sac

# cd ../../../seedfiles

# done 

# cd ..

# echo "###################################  2addeventff.x   ##########################################"
# echo "#################     adding the event information to the sac headers    ######################"
# echo "###############################################################################################"

# for ev in ` awk '{ print $1}' evfullist.dat`; do
# echo $ev

# evd=`grep "$ev" evfullist.dat` 
# echo $evd

# cd $ev
# cd CNDC

# echo "rh *.SAC" > addev.$ev.macro
# echo $evd | awk -F" " '{printf( "%s "," ch EVLA "$8" EVLO "$9" EVDP "$10" MAG "$12);}' >> addev.$ev.macro

# ls *.SAC >> saclist.dat
# jul=`head -1 saclist.dat | awk 'BEGIN{FS="."}{print $2}'`

# echo " " | awk '{printf(" \n");}'  >> addev.$ev.macro

# echo $evd $jul | awk -F" " -v j="$jul" '{printf( "%s "," ch O GMT "$2" "j" "$5" "$6" "$7" "000);}' >> addev.$ev.macro
# echo " " | awk '{printf(" \n");}'  >> addev.$ev.macro
# echo "wh" >> addev.$ev.macro
# echo " " | awk '{printf(" \n");}'  >> addev.$ev.macro
# echo "q" >> addev.$ev.macro

# sac addev.$ev.macro

# rm addev.$ev.macro
# cd ../../
# echo "$ev   done with adding EVLA EVLO DIST " >> addevResult.dat
# done

# echo  "##################################### 3remresff.x #######################################"
# echo  "####################       removing the instrument responce     #########################"
# echo  "#########################################################################################"

# cp evfullist.dat evfullist2.dat
# for ev in ` awk '{ print $1}' evfullist2.dat`; do
# echo $ev

# evd=`grep "$ev" evfullist2.dat` 

# echo $evd
 
# cd $ev
# mkdir Icorrf
# mkdir Icorrf/Dsp 
# mkdir Icorrf/Vel 
# mkdir Icorrf/Acc

# cd CNDC

# rm -f -r resrem.mac

# t=`ls *.SAC | awk 'NR==1'`
# cp $t ../Icorrf/

# ls *.SAC | awk -F"." '{print $2,$3}' | sort | uniq -c > stn_3c.id
# ## rename the SAC filename to something like NET.STN.BH[ZNE].SAC
# ## find the station name which has three seismograms (three components)
# ls *.SAC | awk -F"." '{print $7,$8}' | sort | uniq -c | awk '{if ($1 == 3) print $2,$3}' | sort | uniq > stn_3c.id
# ls `awk '{print "*"$1"."$2".*SAC"}' stn_3c.id` | awk -F"." '{print "mv "$0,$7"."$8"."$10"."$12}' | sh
# ## move the rest into backup for now

# ls *.SAC > saclist4.dat
# awk -F"." '{print $2}' saclist4.dat | sort -u | uniq -u > stnam4.dat
# cp stnam4.dat stnam4.2.dat

# k=` awk 'END{ print NR}' stnam4.2.dat`
# echo "Number of Stations:"$k
# echo -------------------------

# for stn in ` awk '{ print $1}' stnam4.2.dat`; do

# arr=(` ls *.SAC | grep "$stn"`) 
# n=${#arr[*]}

# echo ${arr[0]}

# s=` echo ${arr[0]} | awk 'BEGIN{FS="."}{ print $2}'`
# c=` echo ${arr[0]} | awk 'BEGIN{FS="."}{ print $3}'`

# r="RESP.CN."$s".."$c
# echo $r

# echo "r ${arr[0]} " > 6macro.mac
# echo "lh DELTA" >> 6macro.mac
# echo "q " >> 6macro.mac
# sac 6macro.mac > del.lh

# del0=`sed -n '9p' del.lh | awk -F "=" '{print $2}'`
# d0=`echo ${del0} | sed 's/[eE]+*/*10^/g' | bc -l`
# echo "$s $c delta: "$d0 >> delta.dat

# FHH=`echo $d0 | awk '{print 0.50/$1}' `
# FHL=`echo $d0 | awk '{print 0.25/$1}' `

# echo "FHH" $FHH
# echo "FHL" $FHL

# echo "r ${arr[0]} " >> resrem.mac
# echo "rmean " >> resrem.mac
# echo "rtrend " >> resrem.mac
# echo "taper " >> resrem.mac
# echo "TRANSFER FROM EVALRESP FNAME $r TO NONE FREQLIM 0.8 1.4 11 22 PREW 4" >> resrem.mac
# echo "w ../Icorrf/Dsp/CN."$s"."$c".dsp" >> resrem.mac

# echo "r ${arr[0]} " >> resrem.mac
# echo "rmean " >> resrem.mac
# echo "rtrend " >> resrem.mac
# echo "taper t c w .02 " >> resrem.mac
# echo "TRANSFER FROM EVALRESP FNAME $r TO VEL FREQLIM 0.8 1.4 11 22 PREW 4" >> resrem.mac
# echo "w ../Icorrf/Vel/CN."$s"."$c".vel" >> resrem.mac

# echo "r ${arr[0]} " >> resrem.mac
# echo "rmean " >> resrem.mac
# echo "rtrend " >> resrem.mac
# echo "taper t c w .02 " >> resrem.mac
# echo "TRANSFER FROM EVALRESP FNAME $r TO ACC FREQLIM 0.8 1.4 11 22 PREW 4" >> resrem.mac
# echo "w ../Icorrf/Acc/CN."$s"."$c".acc" >> resrem.mac

# echo ${arr[1]}
# s1=` echo ${arr[1]} | awk 'BEGIN{FS="."}{ print $2}'`
# c1=` echo ${arr[1]} | awk 'BEGIN{FS="."}{ print $3}'`
# r1="RESP.CN."$s1".."$c1
# echo $r1

# echo "r ${arr[1]} " > 6macro.mac
# echo "lh DELTA" >> 6macro.mac
# echo "q " >> 6macro.mac
# sac 6macro.mac > del.lh

# del1=`sed -n '9p' del.lh | awk -F "=" '{print $2}'`
# d1=`echo ${del1} | sed 's/[eE]+*/*10^/g' | bc -l`
# echo "$s1 $c1 delta: "$d1 >> delta.dat

# FHH=`echo $d1 | awk '{print 0.50/$1}' `
# FHL=`echo $d1 | awk '{print 0.25/$1}' `

# echo "FHH" $FHH
# echo "FHL" $FHL

# echo "r ${arr[1]} " >> resrem.mac
# echo "rmean " >> resrem.mac
# echo "rtrend " >> resrem.mac
# echo "taper t c w .02 " >> resrem.mac
# echo "TRANSFER FROM EVALRESP FNAME $r1 TO NONE FREQLIM 0.8 1.4 11 22 PREW 4" >> resrem.mac
# echo "w ../Icorrf/Dsp/CN."$s1"."$c1".dsp" >> resrem.mac

# echo "r ${arr[1]} " >> resrem.mac
# echo "rmean " >> resrem.mac
# echo "rtrend " >> resrem.mac
# echo "taper t c w .02 " >> resrem.mac
# echo "TRANSFER FROM EVALRESP FNAME $r1 TO VEL FREQLIM 0.8 1.4 11 22 PREW 4" >> resrem.mac
# echo "w ../Icorrf/Vel/CN."$s1"."$c1".vel" >> resrem.mac

# echo "r ${arr[1]} " >> resrem.mac
# echo "rmean " >> resrem.mac
# echo "rtrend " >> resrem.mac
# echo "taper t c w .02 " >> resrem.mac
# echo "TRANSFER FROM EVALRESP FNAME $r1 TO ACC FREQLIM 0.8 1.4 11 22 PREW 4" >> resrem.mac
# echo "w ../Icorrf/Acc/CN."$s1"."$c1".acc" >> resrem.mac

# echo ${arr[2]}
# s2=` echo ${arr[2]} | awk 'BEGIN{FS="."}{ print $2}'`
# c2=` echo ${arr[2]} | awk 'BEGIN{FS="."}{ print $3}'`
# r2="RESP.CN."$s2".."$c2
# echo $r2

# echo "r ${arr[2]} " > 6macro.mac
# echo "lh DELTA" >> 6macro.mac
# echo "q " >> 6macro.mac
# sac 6macro.mac > del.lh

# del2=`sed -n '9p' del.lh | awk -F "=" '{print $2}'`
# d2=`echo ${del2} | sed 's/[eE]+*/*10^/g' | bc -l`

# echo "$s2 $c2 delta: "$d2 >> delta.dat

# FHH=`echo $d2 | awk '{print 0.50/$1}' `
# FHL=`echo $d2 | awk '{print 0.25/$1}' `

# echo "FHH" $FHH
# echo "FHL" $FHL

# echo "r ${arr[2]} " >> resrem.mac
# echo "rmean " >> resrem.mac
# echo "rtrend " >> resrem.mac
# echo "taper t c w .02 " >> resrem.mac
# echo "TRANSFER FROM EVALRESP FNAME $r2 TO NONE FREQLIM 0.8 1.4 11 22 PREW 4" >> resrem.mac
# echo "w ../Icorrf/Dsp/CN."$s2"."$c2".dsp" >> resrem.mac

# echo "r ${arr[2]} " >> resrem.mac
# echo "rmean " >> resrem.mac
# echo "rtrend " >> resrem.mac
# echo "taper t c w .02 " >> resrem.mac
# echo "TRANSFER FROM EVALRESP FNAME $r2 TO VEL FREQLIM 0.8 1.4 11 22 PREW 4" >> resrem.mac
# echo "w ../Icorrf/Vel/CN."$s2"."$c2".vel" >> resrem.mac

# echo "r ${arr[2]} " >> resrem.mac
# echo "rmean " >> resrem.mac
# echo "rtrend " >> resrem.mac
# echo "taper t c w .02 " >> resrem.mac
# echo "TRANSFER FROM EVALRESP FNAME $r2 TO ACC FREQLIM 0.8 1.4 11 22 PREW 4" >> resrem.mac
# echo "w ../Icorrf/Acc/CN."$s2"."$c2".dsp" >> resrem.mac

# let k=$(($k-1))
# echo " Remaining Stations:"$k

# tail -"$k" stnam4.2.dat > 4.2temp
# mv 4.2temp stnam4.2.dat
# done 
# echo "q" >> resrem.mac

# sac resrem.mac
# rm -f stn_3c.id
# rm saclist4.dat
# rm -f stnam4.2.dat
# rm -f stnam4.dat
# rm -f 4.2temp
# rm -f -r 6macro.mac
# rm -f del.lh
# rm -f -r resrem.mac
# rm -f tem

# cd ../../

# done

# echo  "################################  5check.qualityff.x  ##################################"
# echo  "##########################  final check & making qualityf.dat   ########################"
# echo  "########################################################################################"

# e=` awk 'END{ print NR}' evfullist2.dat`

# for ev in ` awk '{ print $1}' evfullist2.dat`; do
# echo -------------------------
# echo " Number oof Events: "$e
# echo -------------------------
# echo "Event Name:"$ev
# echo -------------------------
# cd $ev
# cd Icorrf
# cd Vel

# ls *.vel | awk -F"." '{print $1,$2}' | sort | uniq -c > ../stn.dat
# cd ..                       

# echo "Record Quality: " > qualityf.dat
# echo "A - Good" >> qualityf.dat
# echo "B - Bad, problem with component" >> qualityf.dat
# echo "? - Accepted, but might have problem" >> qualityf.dat
# echo "C - Clipped" >> qualityf.dat
# echo "D - directivity" >> qualityf.dat
# echo "N - radiation effect" >> qualityf.dat
# echo "M - missing data in waveform" >> qualityf.dat
# echo "O - Orientation missing" >> qualityf.dat
# echo "S - spikes in data" >> qualityf.dat
# echo "X - no data - in noise" >> qualityf.dat
# echo "station comment" >> qualityf.dat

# k=` awk 'END{ print NR}' stn.dat`
# echo "Number of Stations:"$k
# echo -------------------------
# for stn in ` awk '{ print $3}' stn.dat`; do
# echo $stn

# echo "r [D,A,V]??/*$stn* " > 7macro.mac
# echo "qdp off " >> 7macro.mac
# echo "p1" >> 7macro.mac
# sac 7macro.mac

# echo ---------------------------------------
# echo "A - Good" 
# echo "B - Bad, problem with component" 
# echo "? - Accepted, but might have problem" 
# echo "C - Clipped" 
# echo "D - directivity" 
# echo "N - radiation effect" 
# echo "M - missing data in waveform" 
# echo "O - Orientation missing" 
# echo "S - spikes in data" 
# echo "X - no data - in noise" 

# echo "x - delete" 
# echo ----------------------------------------
# echo what you think ?
# read com
                  
# echo "$stn      $com " >> qualityf.dat

# if [ "$com" == "x" ]; 
# then 
# rm [A,D,V]??/*$stn*
# fi 

# let k=$(($k-1))
# echo " Remaining Stations:"$k

# tail -"$k" stn.dat > temp
# mv temp stn.dat
# read -p next
 
# done 
# mv qualityf.dat ..
# rm -f stn.dat
# rm -r -f 7macro.mac
# rm -f temp

# cd ../../
# let e=$(($e-1))

# tail -"$e" evfullist2.dat > 3.3temp
# mv 3.3temp evfullist2.dat
# read -p next
# rm -f 3.3temp

# done

# echo "#######################################  5snrff.x  ##############################################"
# echo "###################      Auto Quality checking and Calculating SNR         ######################"
# echo "#################################################################################################"

# e=` awk 'END{ print NR}' evfullist2.dat`

# for ev in ` awk '{ print $1}' evfullist2.dat`; do
# echo -------------------------
# echo " Number oof Events: "$e
# echo -------------------------
# echo "Event Name:"$ev
# echo -------------------------
# cd $ev
# cd Icorrf
# cd Vel

# ls *.vel | awk -F"." '{print $2}' | sort | uniq -c > stn.dat
         
# echo "Record Quality: " > quality.dat
# echo "H - High Quality" >> quality.dat
# echo "L - Low Quality" >> quality.dat
# echo "station comment SNR" >> quality.dat

# k=` awk 'END{ print NR}' stn.dat`
# echo "Number of Stations:"$k
# echo -------------------------
# for stn in ` awk '{ print $2}' stn.dat`; do
# arr=(` ls *.vel | grep "$stn"`) 
# echo ${arr[*]}

# echo "r ${arr[0]} ${arr[1]} ${arr[2]}" > 3.1.macro.mac
# echo "lh OMARKER DIST" >> 3.1.macro.mac
# echo "q" >> 3.1.macro.mac
# sac 3.1.macro.mac > o.dis.lh

# echo "r ${arr[0]}" > rddisaz.macro
# echo "lh KSTNM AZ BAZ GCARC " >> rddisaz.macro
# echo "q" >> rddisaz.macro

# sac rddisaz.macro | grep "KSTNM" | awk '{printf( "%s", $3" "); }' >> azdistlist.txt 
# sac rddisaz.macro | grep "AZ" | awk '{printf( "%s", $3" "); }' >> azdistlist.txt
# sac rddisaz.macro | grep "BAZ" | awk '{printf( "%s", $3" "); }' >> azdistlist.txt
# echo " " | awk '{printf(" \n");}' >> azdistlist.txt

# origin=`sed -n '9p' o.dis.lh | awk -F "=" '{print $2}'`
# dist=`sed -n '10p' o.dis.lh | awk -F "=" '{print $2}'`

# o=`echo ${origin} | sed 's/[eE]+*/*10^/g' | bc -l`
# d=`echo ${dist} | sed 's/[eE]+*/*10^/g' | bc -l`
# echo "origin time: "$o 
# echo "distance: "$d

# t1=$(echo "$d/5.8"+"$o" | bc -l)
# t2=$(echo "$d/5"+"$o" | bc -l)
# t3=$(echo "$d/3.6"+"$o" | bc -l)
# t4=$(echo "$d/3.0"+"$o" | bc -l)

# echo $t1
# echo $t2 
# echo $t3
# echo $t4

# echo "r ${arr[0]} ${arr[1]} ${arr[2]}" > 3.2.macro.mac
# echo "sync" >> 3.2.macro.mac
# echo "MTW $t1 $t2 " >> 3.2.macro.mac
# echo "RMS to user1 " >> 3.2.macro.mac
# echo "MTW $t3 $t4 " >> 3.2.macro.mac
# echo "RMS to user2 " >> 3.2.macro.mac
# echo "lh user1 user2 " >> 3.2.macro.mac
# echo "q" >> 3.2.macro.mac
# sac 3.2.macro.mac > u1.u2.lh

# st=` echo ${arr[0]} | awk 'BEGIN{FS="."}{ print $2}'`
# cm=` echo ${arr[0]} | awk 'BEGIN{FS="."}{ print $3}'`
# echo $cm
# echo $st
# st1=` echo ${arr[1]} | awk 'BEGIN{FS="."}{ print $2}'`
# cm1=` echo ${arr[1]} | awk 'BEGIN{FS="."}{ print $3}'`
# echo $cm1
# echo $st1
# st2=` echo ${arr[2]} | awk 'BEGIN{FS="."}{ print $2}'`
# cm2=` echo ${arr[2]} | awk 'BEGIN{FS="."}{ print $3}'`
# echo $cm2
# echo $st2

# us01=` sed -n '9p' u1.u2.lh | awk -F "=" '{print $2}'`
# us02=` sed -n '10p' u1.u2.lh | awk -F "=" '{print $2}'`

# u01=`echo ${us01} | sed 's/[eE]+*/*10^/g' | bc -l`
# u02=`echo ${us02} | sed 's/[eE]+*/*10^/g' | bc -l`

# echo $u01 
# echo $u02

# us11=`sed -n '15p' u1.u2.lh | awk -F "=" '{print $2}'`
# us12=`sed -n '16p' u1.u2.lh | awk -F "=" '{print $2}'`
 
# u11=`echo ${us11} | sed 's/[eE]+*/*10^/g' | bc -l`
# u12=`echo ${us12} | sed 's/[eE]+*/*10^/g' | bc -l`

# echo $u11 
# echo $u12

# us21=`sed -n '21p' u1.u2.lh | awk -F "=" '{print $2}'`
# us22=`sed -n '22p' u1.u2.lh | awk -F "=" '{print $2}'`

# u21=`echo ${us21} | sed 's/[eE]+*/*10^/g' | bc -l`
# u22=`echo ${us22} | sed 's/[eE]+*/*10^/g' | bc -l`

# echo $u21 
# echo $u22

# snr0=$(echo "$u02/$u01" | bc -l)
# snr1=$(echo "$u12/$u11" | bc -l)
# snr2=$(echo "$u22/$u21" | bc -l)

# if [[ $(echo "if ($snr0 >= 2) 1 else 0" | bc) -eq 1 ]]; then
# echo " CN.$st.$cm   H  $snr0" >> quality.dat
# else 
# echo " CN.$st.$cm   L $snr0 " >> quality.dat
# fi 

# if [[ $(echo "if ($snr1 >= 2) 1 else 0" | bc) -eq 1 ]]; then
# echo " CN.$st1.$cm1   H $snr1" >> quality.dat
# else 
# echo " CN.$st1.$cm1   L $snr1" >> quality.dat
# fi 

# if [[ $(echo "if ($snr2 >= 2) 1 else 0" | bc) -eq 1 ]]; then
# echo " CN.$st2.$cm2   H $snr2" >> quality.dat
# else 
# echo " CN.$st2.$cm2   L $snr2" >> quality.dat

# fi 

# if [[ $(echo "if ($snr0 >= 2) 1 else 0" | bc) -eq 0 && $(echo "if ($snr1 >= 2) 1 else 0" | bc) -eq 0 ]]; then
# echo "oooof"
# rm ../[D,A,V]??/*$st1*

# elif [[ $(echo "if ($snr0 >= 2) 1 else 0" | bc) -eq 0 && $(echo "if ($snr2 >= 2) 1 else 0" | bc) -eq 0 ]]; then
# echo "oooof"
# rm ../[D,A,V]??/*$st1*

# elif [[ $(echo "if ($snr1 >= 2) 1 else 0" | bc) -eq 0 && $(echo "if ($snr2 >= 2) 1 else 0" | bc) -eq 0 ]]; then
# echo "oooof"
# rm ../[D,A,V]??/*$st1*

# fi

# let k=$(($k-1))
# echo " Remaining Stations:"$k

# tail -"$k" 3stnam.dat > 3.2temp
# mv 3.2temp 3stnam.dat

# done 
# mv quality.dat ../../.

# rm -f saclist.dat
# rm -f stnam.d
# rm -f 3stnam.dat
# rm -f 3.1.macro.mac
# rm -f o.dis.lh
# rm -f 3.2.macro.mac
# rm -f u1.u2.lh
# rm -f 3.2temp
# rm -f stn.dat
# rm -r -f rddisaz.macro

# cd ..

# cd ../../
# done

# echo "######################################  6rotateff.x  #############################################"
# echo "############################       Rotating final output       ###################################"
# echo "##################################################################################################"

# e=` awk 'END{ print NR}' evfullist2.dat`

# for ev in ` awk '{ print $1}' evfullist2.dat`; do
# echo $ev

# cd $ev
# cd Icorrf/Vel

# ls *.vel | awk -F"." '{print $1,$2}' | sort | uniq -c | awk '{if ($1 == 3) print $2,$3}' | sort | uniq > stn_3c.id

# ls *.vel> saclist5.dat
# awk -F"." '{print $2}' saclist5.dat | sort -u | uniq -u > stnam5.dat
# k=` awk 'END{ print NR}' stnam5.dat`
# echo -------------------------

# for stn in ` awk '{ print $1}' stnam5.dat`; do

# echo "r CN.$stn.??N.vel " > 5macro.mac
# echo "ch CMPAZ 0 CMPINC 90 " >> 5macro.mac
# echo "wh " >> 5macro.mac
# echo "r CN.$stn.??E.vel " >> 5macro.mac
# echo "ch CMPAZ 90 CMPINC 90 " >> 5macro.mac
# echo "wh " >> 5macro.mac
# echo "q " >> 5macro.mac

# sac 5macro.mac

# tail -"$k" stnam5.dat > 3.2temp
# mv 3.2temp stnam5.dat

# done

# saclst e f `awk '{print $1"."$2".?H[EN].vel"}' stn_3c.id` 
# saclst e f `awk '{print $1"."$2".?H[EN].vel"}' stn_3c.id` |\
# paste - - | awk '{if ($2> $4) print $4;else print $2}' > BH_EN_end_time.dat
# saclst b f `awk '{print $1"."$2".?H[EN].vel"}' stn_3c.id` |\
# paste - - | awk '{if ($2< $4) print $4;else print $2}' > BH_EN_start_time.dat
# paste -d" " stn_3c.id BH_EN_start_time.dat BH_EN_end_time.dat |\
# awk '{print "cut "$3,$4"\nr "$1"."$2".?H[EN].vel\nrmean\nrtrend\nrotate to GCP\nw "$1"."$2".HHR.vel "$1"."$2".HHT.vel"} END {print "q"}' | sac
# awk '{print "r "$1"."$2".*.vel\nrmean\nrtrend\nw over"} END {print "q"}' stn_3c.id | sac

# rm -f 3.2temp
# rm -f saclist5.dat
# rm -f stnam5.dat
# rm -f stn_3c.id
# rm -f BH_EN_end_time.dat
# rm -f BH_EN_start_time.dat
# rm -f -r 5macro.mac

# cd ..
# cd Acc

# ls *.acc | awk -F"." '{print $1,$2}' | sort | uniq -c | awk '{print $2,$3}' | sort | uniq > stn_3c.id

# ls *.acc> saclist5.dat
# awk -F"." '{print $2}' saclist5.dat | sort -u | uniq -u > stnam5.dat
# k=` awk 'END{ print NR}' stnam5.dat`
# echo -------------------------

# for stn in ` awk '{ print $1}' stnam5.dat`; do

# echo "r CN.$stn.??N.acc " > 5macro.mac
# echo "ch CMPAZ 0 CMPINC 90 " >> 5macro.mac
# echo "wh " >> 5macro.mac
# echo "r CN.$stn.??E.acc " >> 5macro.mac
# echo "ch CMPAZ 90 CMPINC 90 " >> 5macro.mac
# echo "wh " >> 5macro.mac
# echo "q " >> 5macro.mac

# sac 5macro.mac

# tail -"$k" stnam5.dat > 3.2temp
# mv 3.2temp stnam5.dat

# done

# saclst e f `awk '{print $1"."$2".?H[EN].acc"}' stn_3c.id` 
# saclst e f `awk '{print $1"."$2".?H[EN].acc"}' stn_3c.id` |\
# paste - - | awk '{if ($2> $4) print $4;else print $2}' > BH_EN_end_time.dat
# saclst b f `awk '{print $1"."$2".?H[EN].acc"}' stn_3c.id` |\
# paste - - | awk '{if ($2< $4) print $4;else print $2}' > BH_EN_start_time.dat
# paste -d" " stn_3c.id BH_EN_start_time.dat BH_EN_end_time.dat |\
# awk '{print "cut "$3,$4"\nr "$1"."$2".?H[EN].acc\nrmean\nrtrend\nrotate to GCP\nw "$1"."$2".HHR.acc "$1"."$2".HHT.acc"} END {print "q"}' | sac
# awk '{print "r "$1"."$2".*.acc\nrmean\nrtrend\nw over"} END {print "q"}' stn_3c.id | sac

# rm -f 3.2temp
# rm -f saclist5.dat
# rm -f stnam5.dat
# rm -f stn_3c.id
# rm -f BH_EN_end_time.dat
# rm -f BH_EN_start_time.dat
# rm -f -r 5macro.mac

# cd ..
# cd Dsp

# ls *.dsp | awk -F"." '{print $1,$2}' | sort | uniq -c | awk '{print $2,$3}' | sort | uniq > stn_3c.id

# ls *.dsp> saclist5.dat
# awk -F"." '{print $2}' saclist5.dat | sort -u | uniq -u > stnam5.dat
# k=` awk 'END{ print NR}' stnam5.dat`
# echo -------------------------

# for stn in ` awk '{ print $1}' stnam5.dat`; do

# echo "r CN.$stn.??N.dsp " > 5macro.mac
# echo "ch CMPAZ 0 CMPINC 90 " >> 5macro.mac
# echo "wh " >> 5macro.mac
# echo "r CN.$stn.??E.dsp " >> 5macro.mac
# echo "ch CMPAZ 90 CMPINC 90 " >> 5macro.mac
# echo "wh " >> 5macro.mac
# echo "q " >> 5macro.mac

# sac 5macro.mac

# tail -"$k" stnam5.dat > 3.2temp
# mv 3.2temp stnam5.dat

# done

# saclst e f `awk '{print $1"."$2".?H[EN].dsp"}' stn_3c.id` 
# saclst e f `awk '{print $1"."$2".?H[EN].dsp"}' stn_3c.id` |\
# paste - - | awk '{if ($2> $4) print $4;else print $2}' > BH_EN_end_time.dat
# saclst b f `awk '{print $1"."$2".?H[EN].dsp"}' stn_3c.id` |\
# paste - - | awk '{if ($2< $4) print $4;else print $2}' > BH_EN_start_time.dat
# paste -d" " stn_3c.id BH_EN_start_time.dat BH_EN_end_time.dat |\
# awk '{print "cut "$3,$4"\nr "$1"."$2".?H[EN].dsp\nrmean\nrtrend\nrotate to GCP\nw "$1"."$2".HHR.dsp "$1"."$2".HHT.dsp"} END {print "q"}' | sac
# awk '{print "r "$1"."$2".*.dsp\nrmean\nrtrend\nw over"} END {print "q"}' stn_3c.id | sac

# rm -f 3.2temp
# rm -f saclist5.dat
# rm -f stnam5.dat
# rm -f stn_3c.id
# rm -f BH_EN_end_time.dat
# rm -f BH_EN_start_time.dat
# rm -f -r 5macro.mac

# cd ../../../

# tail -"$e" evfullist2.dat > 5temp
# mv 5temp evfullist2.dat

# done
# rm -f 5temp

# echo "###################################  7ampmaker.x  ################################################"
# echo "########################        amplitute calculation       ######################################"
# echo "##################################################################################################"



# echo "#####################################  8plottingff.x  ###########################################"
# echo "#################################         plotting         ######################################"
# echo "#################################################################################################"

# e=` awk 'END{ print NR}' evfullist2.dat`

# for ev in ` awk '{ print $1}' evfullist2.dat`; do
# echo -------------------------
# echo " Number oof Events: "$e
# echo -------------------------
# echo "Event Name:"$ev
# echo -------------------------

# cd $ev
# cd Icorrf

# echo ">" > path.gmt
# echo "" > station.gmt

# echo 
# for stn in ` awk '{ print $2}' stn.dat`; do

# grep "$stn" $ev.vel.out > temp
# cat temp | awk -F" " '{printf( "%s ",$5" "$6);}' >> path.gmt
# echo " " | awk '{printf(" \n");}' >> path.gmt
# cat temp | awk -F" " '{printf( "%s ",$8" "$9);}' >> path.gmt
# echo " " | awk '{printf(" \n");}' >> path.gmt
# echo ">" >> path.gmt

# cat temp | awk -F" " '{printf( "%s ",$8" "$9);}' >>  station.gmt
# echo " " | awk '{printf(" \n");}' >> station.gmt

# done

# REGION=-90/-45/35/60
# size=20c
# fromXaxis=4
# fromYaxis=3
# title=${ev}

##########   set defaults
# WHITE=255
# LTGRAY=192
# VLTGRAY=225
# EXTGRAY=250
# GRAY=128
# BLACK=0
# RED=250/0/0
# DKRED=196/50/50
# BLUE=0/0/255
# GREEN=0/255/0
# YELLOW=255/255/50
# ORANGE=255/192/50
# PURPLE=255/50/255
# CYAN=50/255/255
# LTBLUE=192/192/250
# VLTBLUE=225/250/250
# LTRED=250/225/225
# PINK=255/225/255
# BROWN=160/64/32

# gmtset MEASURE_UNIT cm

########  basemap
# psbasemap -R${REGION} -JM${size} -Ba2f2g1/a2f2g1:.${title}: -X${fromXaxis} -Y${fromYaxis} -K > $0.ps

########  converting the img file to the grd file
# img2grd ../../../topo_8.2.img -R$REGION -Gtopo2.grd -T1 

########  making the CPT
# makecpt -Cglobe -T-12000/12000/500 -Z > topo.cpt

########   grdgradient grd to gradient
# grdgradient ../../../topo2.grd -Gtopo.grad -A5 -Nt0.9

##########  ploting the grd file on map
# grdimage ../../../topo2.grd -Ctopo.cpt -Itopo.grad -JM${size} -R${REGION} -B1000g10000nSeW -Sb -K -O >> $0.ps

##########   cost line data
# pscoast -R${REGION} -JM${size} -W1 -Df+ -A10000 -K -O -Na/3/0 >> $0.ps

##### DRAW LINES 
# psxy path.gmt -R${REGION} -JM${size} -M -K -O -W1  >> $0.ps

###### plot stations
# cat station.gmt | awk -F" " '{print("\n", $1" "$2);}' > lo.xy
# psxy lo.xy -R${REGION} -JM${size} -St.2 -M -W1/0 -G$RED -K -O >> $0.ps

###### plot Earthquake 
# awk '{print $5,$6}' temp | head -1000 > locations.xy
# psxy locations.xy -R${REGION} -JM${size} -Sc0.2c -W1/0 -G$YELLOW -M -K -O >> $0.ps

########## Scale Bar
# pscoast -R${REGION} -JM${size} -W1 -K -O -Lf-93/32.5/32.7/100 -V >> $0.ps 

#########    plotting legend
# pstext -R -J -O -K << END >> $0.ps
# -93.5 33.4 12 0 0 0 Stations
# -93.5 33.2 12 0 0 0 Earthquake	
# END

# echo -89.0 36.45 | psxy -R -J -St.2 -W1/0 -G$RED -O -K >> $0.ps
# echo -89.0 36.25 | psxy -R -J -Sc0.2c -W1/0 -G$YELLOW -O  >> $0.ps

# #gv $0.ps &

# rm topo2.grd 
# rm topo.grad
# rm topo.cpt
# #rm station.gmt
# rm lo.xy
# rm locations.xy
# #rm temp
# #rm evlist.dat
# #rm path.gmt

# cd ../../
# done

# echo "################################  9traveltimeff.x  ##########################################" 
# echo "########################        Travel tim plot       #######################################"
# echo "#############################################################################################"

# echo "which azimuth ?"
# read az 
# echo "which velocity ?"
# read vel

# for ev in ` awk '{ print $1}' evfullist2.dat`; do
# echo -------------------------
# echo "Event Name:"$ev
# echo -------------------------
# cd $ev
# cd Icorrf
# cd Vel

# rm -f $az.list
# rm -f azdistlist.txt 

# azb=$(echo "$az-10" | bc -l)
# aze=$(echo "$az+10" | bc -l)

# echo "lower limit of azimouth: "$azb
# echo "upper limit of azimouth: "$aze

# for i in ` awk '{ print $2}' ../stn.dat`; do
# echo $i

# echo "r  CN."$i".??Z.vel" > rddisaz.macro
# echo "lh KSTNM AZ BAZ  " >> rddisaz.macro
# echo "q" >> rddisaz.macro

# sac rddisaz.macro | grep "KSTNM" | awk '{printf( "%s", $3" "); }' >> azdistlist.txt 
# sac rddisaz.macro | grep "AZ" | awk '{printf( "%s", $3" "); }' >> azdistlist.txt
# sac rddisaz.macro | grep "BAZ" | awk '{printf( "%s", $3" "); }' >> azdistlist.txt
# echo " " | awk '{printf(" \n");}' >> azdistlist.txt

# done 

# for st in ` awk '{ print $1}'  azdistlist.txt`; do
# echo $st
# grep "$st"  azdistlist.txt > temp11

# a=` cat temp11 | awk -F" " '{printf( "%s ",$2);}'`
# echo $a

# azz=`echo ${a} | sed 's/[eE]+*/*10^/g' | bc -l`
# echo $azz

# if [[ $(echo "if ($azz >= $azb) 1 else 0" | bc) -eq 1 && $(echo "if ($azz <= $aze) 1 else 0" | bc) -eq 1 ]]; then

# echo "$st" >> $az.list
# fi 

# done 

# if [[ -a $az.list ]]; then

# cat $az.list | awk '{printf ("%s ", " r more CN."$1".??Z.vel");}' > prs.macro
# echo " " >> prs.macro

# echo "sss" >> prs.macro

# echo "vm 1 refractedwave vapp $vel" >> prs.macro
# echo "timewindow 30 600" >> prs.macro
# echo "title on "reduced velocity of $vel azimuth $az"" >> prs.macro  
# echo "bd sgf" >> prs.macro 
# echo "prs O r" >> prs.macro
# echo "ed sgf" >> prs.macro 
# echo "sgftops f001.sgf f001.ps" >> prs.macro
# echo " q" >> prs.macro

# sac prs.macro
# mv f001.ps $az.$vel.$ev.ps
# # gv $az.$vel.$ev.ps

# mv $az.$vel.$ev.ps ../.

# else 
# echo  "####################################################################"
# echo "# No stations within this azimouth range in $ev # " 
# echo  "####################################################################"

# fi

# rm -f f001.sgf
# #rm -f azdistlist.txt
# rm -f temp11
# rm -f prs.macro
# rm -f rddisaz.macro

# cd ../../../
# done

# echo "########    renaming the original sac files andd rotating the horizontal components    ##########"
# echo "#################################################################################################"

# e=` awk 'END{ print NR}' evfullist2.dat`

# for ev in ` awk '{ print $1}' evfullist2.dat`; do
# echo $ev

# cd $ev
# cd Icorrf/Vel

# ls * | awk -F"." '{print $2,$3}' | sort | uniq -c > stn_3c.id

# ## rename the SAC filename to something like NET.STN.BH[ZNE].SAC
# ## find the station name which has three seismograms (three components)
# #ls *.SAC | awk -F"." '{print $7,$8}' | sort | uniq -c | awk '{if ($1 == 3) print $2,$3}' | sort | uniq > stn_3c.id
# ## rename the SAC filename to NET.STN.BH[ZNE].SAC
# #ls `awk '{print "*"$1"."$2".*SAC"}' stn_3c.id` | awk -F"." '{print "mv "$0,$7"."$8"."$10"."$12}' | sh
# ## move the rest into backup for now
# #mv *.SAC backup

# ls * > saclist5.dat
# awk -F"." '{print $2}' saclist5.dat | sort -u | uniq -u > stnam5.dat
# awk -F"." '{print $4}' saclist5.dat | sort -u | uniq -u > ty.dat

# cp stnam5.dat stnam5.2.dat
# k=` awk 'END{ print NR}' stnam5.2.dat`
# echo -------------------------

# for stn in ` awk '{ print $2}' stnam5.2.dat`; do
# p=` awk '{print $1}' ty.dat`
# echo $p
# echo "r CN.$stn.??N.* " > 5macro.mac
# echo "ch CMPAZ 0 CMPINC 90 " >> 5macro.mac
# echo "wh " >> 5macro.mac
# echo "r CN.$stn.??E.* " >> 5macro.mac
# echo "ch CMPAZ 90 CMPINC 90 " >> 5macro.mac
# echo "wh " >> 5macro.mac
# echo "r CN.$stn.??N.* CN.$stn.??E.* " >> 5macro.mac
# echo "rotate to GCP " >> 5macro.mac
# echo "w CN.$stn.HHR.D.$p *.CN.$stn.HHT.D.$p " >> 5macro.mac
# echo "q " >> 5macro.mac

# sac 5macro.mac

# tail -"$k" stnam5.2.dat > 3.2temp
# mv 3.2temp stnam5.2.dat

# done

# # cut the two horizontal component data so that they will have the same length, which are needed for rotation in SAC.
# # list the end of the two horizontal component data

# #saclst e f `awk '{print $2"."$3".?H[EN].$p"}' stn_3c.id` 
# #saclst e f `awk '{print $2"."$3".?H[EN].$p"}' stn_3c.id` |\
# #paste - - | awk '{if ($2> $4) print $4;else print $2}' > BH_EN_end_time.dat
# #saclst b f `awk '{print $2"."$3".?H[EN].$p"}' stn_3c.id` |\
# #paste - - | awk '{if ($2< $4) print $4;else print $2}' > BH_EN_start_time.dat
# # find out the minimum of the end time and save it
# #paste -d" " stn_3c.id BH_EN_start_time.dat BH_EN_end_time.dat |\
# #awk '{print "cut "$3,$4"\nr "$2"."$3".?H[EN].$p\nrmean\nrtrend\nrotate to GCP\nw "$2"."$3".#HR.$p "$2"."$3".#HT.$p"} END {print "q"}' | sac
# # cut the two horizontal component data, remove mean and trend,
# # rotate them to great circle path, save the output
# # awk '{print "r "$1"."$2".*.$p\nrmean\nrtrend\nw over"} END {print "q"}' stn_3c.id | sac
# # remove mean and trend for the original three component data.

# #rm saclist5.dat
# #rm -f stnam5.dat
# #rm -f stnam4.dat
# #rm -f stn_3c.id
# #rm -f stnam5.2.dat
# #rm -f stnam5.2.dat
# #rm -f BH_EN_end_time.dat
# #rm -f BH_EN_start_time.dat
# #rm -f -r 5macro.mac
# cd ../

# cd ../../

# tail -"$e" evfullist2.dat > 5temp
# mv 5temp evfullist2.dat

# done
# rm -f 5temp

# echo "########################################  11pspicking.x  ########################################"
# echo "#################       picking P and S arrivals  and making quality.dat     ####################"
# echo "#################################################################################################"
# e=` awk 'END{ print NR}' evfullist2.dat`

# for ev in ` awk '{ print $1}' evfullist2.dat`; do
# echo -------------------------
# echo " Number oof Events: "$e
# echo -------------------------
# echo "Event Name:"$ev
# echo -------------------------
# cd $ev
# cd CNDC
                                   
# awk -F"." '{print $8}' saclist.dat | sort -u | uniq -u > stnam.d

# echo "Record Quality: " > quality.dat
# echo "A - Good" >> quality.dat
# echo "B - Bad, problem with component" >> quality.dat
# echo "? - Accepted, but might have problem" >> quality.dat
# echo "C - Clipped" >> quality.dat
# echo "D - directivity" >> quality.dat
# echo "N - radiation effect" >> quality.dat
# echo "M - missing data in waveform" >> quality.dat
# echo "O - Orientation missing" >> quality.dat
# echo "S - spikes in data" >> quality.dat
# echo "X - no data - in noise" >> quality.dat
# echo "net stn cmp  comment" >> quality.dat

# cp stnam.d 3stnam.dat
# k=` awk 'END{ print NR}' 3stnam.dat`
# echo "Number of Stations:"$k
# echo -------------------------
# for stn in ` awk '{ print $1}' 3stnam.dat`; do
# ls *.SAC | grep "$stn" > 3temp
# arr=(` ls *.SAC | grep "$stn"`) 
# n=${#arr[*]}
# if [ "$n" == "3" ]; then
# echo $n
# echo ${arr[*]}
# echo "r ${arr[0]} ${arr[1]} ${arr[2]}" > 3macro.m
# echo "qdp off " >> 3macro.m
# echo "rmean" >> 3macro.m
# echo "sync" >> 3macro.m
# echo "hp bu co 0.5 n 4 p 2 " >> 3macro.m
# echo "p1" >> 3macro.m
# sac 3macro.m 
# echo ---------------------------------------
# echo "A - Good" 
# echo "B - Bad, problem with component" 
# echo "? - Accepted, but might have problem" 
# echo "C - Clipped" 
# echo "D - directivity" 
# echo "N - radiation effect" 
# echo "M - missing data in waveform" 
# echo "O - Orientation missing" 
# echo "S - spikes in data" 
# echo "X - no data - in noise" 
# echo ----------------------------------------
# echo what you think A B ? C D N M O S X
# read com
                         
# awk -F"." -v c="$com" '{print $7".."$8"."$10"  "c}' 3temp >> quality.dat

# if [ "$com" == "A" ]; then 
# echo "r ${arr[0]} ${arr[1]} ${arr[2]}" > 3macro.m
# echo "qdp off " >> 3macro.m
# echo "rmean" >> 3macro.m
# echo "sync" >> 3macro.m
# echo "bp bu p 2 n 4 c 0.06 0.09" >> 3macro.m
# echo "p1" >> 3macro.m
# echo "lh DIST AMARKER T0MARKER GCARC EVDP" >> 3macro.m
# echo  -------------------------------------------------
# echo " Now Pickk the P & S ( hint: xlim  ppk m   wh ) "
# echo  -------------------------------------------------
# sac 3macro.m 

# elif [ "$com" == "?" ]; then 
# echo "r ${arr[0]} ${arr[1]} ${arr[2]}" > 3macro.m
# echo "qdp off " >> 3macro.m
# echo "rmean" >> 3macro.m
# echo "sync" >> 3macro.m
# echo "bp bu p 2 n 4 c 0.06 0.09" >> 3macro.m
# echo "p1" >> 3macro.m
# echo "lh DIST AMARKER T0MARKER GCARC EVDP" >> 3macro.m
# echo  -------------------------------------------------
# echo " Now Pickk the P & S ( hint: xlim  ppk m   wh ) "
# echo  -------------------------------------------------
# sac 3macro.m 
# fi 

# let k=$(($k-1))
# echo " Remaining Stations:"$k

# tail -"$k" 3stnam.dat > 3.2temp
# mv 3.2temp 3stnam.dat
# read -p next
# rm -f 3macro.m
# fi 
 
# done 
# mv quality.dat ..

# cd ../../
# let e=$(($e-1))

# tail -"$e" evfullist2.dat > 3.3temp
# mv 3.3temp evfullist2.dat
# read -p next
# rm -f 3.3temp

# done

# echo "#########################################  fft and noise    #####################################"
# echo "#################################################################################################"

# e=` awk 'END{ print NR}' evfullist2.dat`

# for ev in ` awk '{ print $1}' evfullist2.dat`; do
# echo -------------------------
# echo " Number oof Events: "$e
# echo -------------------------
# echo "Event Name:"$ev
# echo -------------------------
# cd $ev
# cd Icorrf

# echo "cut 0 A " > noise.mac
# echo "r Vel/* " >> noise.mac
# echo "cut off " >> noise.mac
# echo "w change vel noise.vel " >> noise.mac
# echo "q " >> noise.mac

# sac noise.mac

# echo "r Vel/* " > fft.mac
# echo "fft " >> fft.mac
# echo "wsp am " >> fft.mac
# echo "q " >> fft.mac

# sac fft.mac

# cd Vel

# ls *.vel | awk -F"." '{print $2,$3}' | sort | uniq -c > stn.dat
# k=` awk 'END{ print NR}' stn.dat`
# echo "Number of Stations:"$k
# echo -------------------------
# for sc in ` awk '{ print $2"."$3}' stn.dat`; do

# echo "qdp 70000 " > 6macro.mac
# echo "loglog" >> 6macro.mac
# echo "xlim .01 50 " >> 6macro.mac
# echo "color 1 i l 7 1 " >> 6macro.mac
# echo "r *.$sc.*.am " >> 6macro.mac
# echo "p2 " >> 6macro.mac
# echo "ppk " >> 6macro.mac

# sac 6macro.mac

# tail -"$k" stn.dat > temp
# mv temp stn.dat
# read -p next

# done 
# cd ..

# rm -f 3.2temp
# #rm -f -r noise.mac
# #rm -f -r ftt.mac

# cd ../../

# tail -"$e" evfullist2.dat > 3.2temp
# mv 3.2temp evfullist2.dat

# done 


