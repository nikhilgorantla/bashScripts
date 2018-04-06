#!/bin/bash

#File dbsearch.sh
#Exectuing instructons 
	# ./ dbsearch.sh 

#Fun little script to search database details.



echo "enter the database name" 
#read $name 
cd /var/SCRIPTS 
OLDIFS=$IFS
IFS=","
while read ipaddress database port dbpath 
do 

	echo -e "\e[0;31m$ipaddress  
	===============================\e[m\n\
	Database name :$ipaddress \n\
	Databse IP:$database \n\
	Database port:$port \n\
	Database path:$dbpath
	==============================="
done < Postgresdb.csv   
#$res
#sh dbsearch.sh | grep $name > $res 
#$res | grep $name 
#Postgresdb.csv   
IFS=$OLDIFS
 
