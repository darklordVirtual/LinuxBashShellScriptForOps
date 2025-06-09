#!/usr/bin/env bash
# Created by PyCharm.
# File:                 LinuxBashShellScriptForOps:${NAME}.sh
# User:                 Guodong
# Create Date:          2017/7/6
# Create Time:          9:13
# Function:             
# Note:                 
# Prerequisite:         
# Description:          
# Reference:

# List listening ports currently bound to local IP addresses
netstat -ltn | sed '1,2d' | awk -F'[ :]+' '{print $5}'
LC_ALL=C netstat -ltn | sed '1,2d' | awk '{print $4}' | awk -F ':' '{print $NF}' | sort -n

# Show listening ports sorted numerically
netstat -nltp | awk 'NR>2{split($4,a,":");t=sprintf("%5d",a[2]);b[t]=$0}END{for(i=0;i++<asorti(b,c);)print b[c[i]]}'
netstat -nolpt | awk 'BEGIN{print "PID/SER\tIP\tPORT"}/^t/{print gensub("([^,]+),(.*):(.*)","\\1 \\2 \\3","g",$7","$4)}' |column -t | sort -k3n

# Show top remote IPs connecting to local ports
netstat -anot | awk '{print $5}' | awk -F ':' '{print $1}' | grep -v 192.168 | sort | uniq -c| sort -n -r | head -n 5
netstat -anopt | grep 6379 | awk -F[\ ]+ '{print $5}' | awk -F':' '{print $1}' | sort | uniq -c |sort -n -r

# Display connection counts to see if there are excessive connections
netstat -n | awk '/^tcp/ {++S[$NF]} END {for(a in S) print a, S[a]}'