#!/bin/sh
username="#########"   # replace uname with your username
password="#########"  # replace passwd with your password
auth=`cat /root/key`
alive=$(curl -s -k --max-time 10 "$auth" | grep -o "$auth")
if [ "$alive" != "$auth" ] || [ "$alive" == "" ]
		then
		time=$(date +%H:%M:%S::%d-%m-%Y)
		magic=$(curl -s -k --max-time 10 "https://192.168.193.1:1442/login?" | grep "name=\"magic\"" | grep -o '\"[a-zA-Z0-9][a-zA-Z0-9][a-zA-Z0-9][a-zA-Z0-9][a-zA-Z0-9][a-zA-Z0-9][a-zA-Z0-9][a-zA-Z0-9]*\"' | grep -o '[a-zA-Z0-9]*')
		if [ "$magic" != "" ]
			then
			auth=$(curl -s -k --max-time 10  "https://192.168.193.1:1442/" --data "4Tredir=https%3A%2F%2F192.168.193.1%3A1442%2Flogin%3F&magic=$magic&username=$username&password=$password"  | grep -Eo "https:\/\/192.168.193.1:1442\/keepalive\?[A-Za-z0-9]+")
			if [ "$auth" != "" ]
				then
				>/root/key
				echo "$auth" >> /root/key
				echo "$auth	$time" >> /root/log
			fi
		fi
fi
exit
