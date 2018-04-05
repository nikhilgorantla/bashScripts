#!/bin/bash

#File dbsize.sh
#Exectuing instructons 
	# ./ dbsize.sh 

#Simple script to dump the daily incremental backup db sizes to a text file.


cd /Dumps/Dailytapeincrementalbackups/$(date -d yesterday +%d-%B-%Y)/DbDumps/
ls *.[bg]* |cut -d ":" -f 1 > backupfilename.txt
ls -l *.[bg]* |awk -F " " '{print $5}' > backupfilesize.txt
paste backupfilename.txt backupFilesize.txt > backuplist`date '+%d-%m-%Y-%H'`.txt

cat /var/SCRIPTS/dbname.txt |
while read name
do
cat backuplist`date '+%d-%m-%Y-%H'`.txt |grep -w $name >> dbsizes`date '+%d-%m-%Y-%H'`.txt
done
cat dbsizes`date '+%d-%m-%Y-%H'`.txt | awk -F " " '{print $2}'
