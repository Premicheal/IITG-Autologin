#!/bin/sh
temp=`cat /root/count`
>/root/count
echo "0" >> /root/count 
echo $(date +%d-%m-%Y) $temp >> /root/daily_log
exit
