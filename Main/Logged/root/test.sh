#!/bin/sh
username="#########"   # replace uname with your username
password="#########"  # replace passwd with your password
auth=`cat /root/key`
alive=$(curl -s -k --max-time 10 "$auth" | grep -o "$auth")
time=$(date +%H:%M:%S::%d-%m-%Y)
ftemp=`cat /root/fcount`
if [ "$alive" != "$auth" ] || [ "$alive" == "" ]
	then
	temp=`cat /root/count`
	temp=$((temp+1))
	if [ "$ftemp" == "0" ]
		then
		echo "$time" >> /root/fail
	fi
	ftemp=$((ftemp+1))
	magic=$(curl -s -k --max-time 10 "https://192.168.193.1:1442/login?" | grep "name=\"magic\"" | grep -o '\"[a-zA-Z0-9][a-zA-Z0-9][a-zA-Z0-9][a-zA-Z0-9][a-zA-Z0-9][a-zA-Z0-9][a-zA-Z0-9][a-zA-Z0-9]*\"' | grep -o '[a-zA-Z0-9]*')
	if [ "$magic" != "" ]
		then
		auth=$(curl -s -k --max-time 10  "https://192.168.193.1:1442/" --data "4Tredir=https%3A%2F%2F192.168.193.1%3A1442%2Flogin%3F&magic=$magic&username=$username&password=$password"  | grep -Eo "https:\/\/192.168.193.1:1442\/keepalive\?[A-Za-z0-9]+")
		if [ "$auth" != "" ]
			then
			>/root/key	
			echo "$auth" >> /root/key
			echo "$auth	$time  $ftemp" >> /root/log
			if [ "$ftemp" != "1" ] 
				then
				echo "                      $time   $ftemp" >> /root/fail
				ftemp="0"
			fi
		fi
	fi
	>/root/count
	>/root/fcount
	echo $ftemp >> /root/fcount	
	echo $temp >> /root/count			
elif [ "$ftemp" != "0" ]
	then
	echo "                      $time      $ftemp" >> /root/fail
	>/root/fcount	
	echo "0" >> /root/fcount
fi
exit
