#!/bin/bash

echo "###################################  1readseedff.x   ##########################################"
echo "#############  Renaming the seed files and making the directory for earthquake  ###############"
echo -------------------------------------------------------------------------------------------------
cp evfullist.dat newprocessing/.

cd seedfiles 
for i in $(ls *); do
echo $i

dy=`echo $i | awk 'BEGIN{FS="."}{print $1}'`
hr=`echo $i | awk 'BEGIN{FS="."}{print $2}'`

j=$dy.$hr.SEED
echo $j 

mv $i $j

mkdir ../newprocessing/canada_$dy.$hr
mkdir ../newprocessing/canada_$dy.$hr/CNDC
#mkdir ../newprocessing/canada_$dy.$hr/CNDC/seed.sac

#cp $dy.$hr.SEED ../newprocessing/canada_$dy.$hr/CNDC/seed.sac/.
cp $dy.$hr.SEED ../newprocessing/canada_$dy.$hr/CNDC/.

#cd ../newprocessing/canada_$dy.$hr/CNDC/seed.sac
cd ../newprocessing/canada_$dy.$hr/CNDC/

rdseed -f $dy.$hr.SEED -R -d -o 1

#for st in `awk '{print $1}' ../../../../station.info`; do 

##mv *.CN.$st..[BH]H[ENZ].?.SAC ../.
#mv *.CN.$st..*.?.SAC ../.

#mv RESP.CN.$st..??? ../.

#done
rm -r -f *.SEED

#cd ../

#rm -r -f seed.sac

cd ../../../seedfiles

done 

cd ..
