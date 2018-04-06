#!/bin/bash

#File pgidlecon.sh
#Exectuing instructons 
	# ./pgidlecon.sh 

#simple script Monitor the postgress idle connections and kill the connections.



clear
echo  "enter the database name"
read   dbname
echo "Selected Database is:"  $dbname
echo "------------------------------------------------------------------------------------------------------"
idle=`ps -ef |grep postgres |grep $dbname | grep idle |grep -v transaction | wc -l`
transactions=`ps -ef |grep postgres | grep $dbname |grep  transaction | wc -l`
insert=`ps -ef |grep postgres | grep $dbname |grep INSERT |wc -l`
select=`ps -ef |grep postgres| grep $dbname  |grep SELECT |wc -l`
update=`ps -ef |grep postgres | grep $dbname |grep UPDATE |wc -l`
total=`expr $idle + $insert + $select + $update + $transactions`
echo "The total No.of connections of $dbname at `date '+%d-%m-%Y-%H-%M'` are $total"  >> /home/pg_idle/total_connections.txt


echo "      Idle        Idle in Transactions      insert       select           update           total"
echo "------------------------------------------------------------------------------------------------------"
printf   "\t$idle\t        $transactions\t\t      $insert\t\t   $select\t\t      $update\t\t      $total\n"            
if [ $idle -ge 100 ]; then
echo "Do you want to kill idle connections (Y/N)"
read answer
if [ "$answer" = "Y" ];  then
echo "
SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE  datname='$dbname' and state = 'idle'; 
" | psql -U postgres template1 -p 9412;
else  
echo "Keep Monitoring Database for Idle Connections"
fi
fi
