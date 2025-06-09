#!/usr/bin/env bash
# Get the default routing IP
# get_default_host_ip
# Verify if an IP address is valid
ipcalc -c 10.20.0.7
# Validate an IP address together with its subnet mask
ipcalc -c 10.104.28.0/255.255.192.0

#egrep is the same as grep -E.
IP=$(ifconfig | grep inet | grep -Ev "(inet6|127.0.0.1)" | awk -F ":" '{print $2}' | awk '{print $1}')
hostname -i
facter ipaddress_eth0
# A system used standard method to get ip address from  '/etc/rc.d/rc.sysinit' line 346 on CentOS, useless for Ubuntu
ip addr show to 0.0.0.0/0 scope global | gawk '/[[:space:]]inet / { print gensub("/.*","","g",$2) }'

# Ubuntu
DEVICE="$(route -n | awk '/^0.0.0.0/ { print $NF  }')"
ip addr show to 0.0.0.0/0 scope global "${DEVICE}" | gawk '/[[:space:]]inet / { print gensub("/.*","","g",$2) }'

# Get all IP
ifconfig | grep inet | egrep -v "(inet6|127.0.0.1)" | cut -d ":" -f2 | cut -d " " -f1

# CentOS IP
DEVICE=$(route -n | awk '/^0.0.0.0/ && /UG/ {print $NF}')
IP=$(ifconfig "${DEVICE}" | awk -F '[ :]+' '/inet/ && !/inet6/ {print $3}')
echo "$IP"

# Ubuntu IP
DEVICE=$(route -n | awk '/^0.0.0.0/ && /UG/ {print $NF}')
IP=$(ifconfig "${DEVICE}" | awk -F '[ :]+' '/inet/ && !/inet6/ {print $4}')
echo "$IP"

# general distro using ip command
# TODO(Guodong Ding) Ubuntu 16.04.1 LTS maybe not support, see 'ip route' for detail
ip addr show scope global "$(ip route | awk '/^default/ {print $NF}')" | awk -F '[ /]+' '/global/ {print $3}'

#without awk or cut
IP1=$(ifconfig | grep inet | grep -Ev "(inet6|127.0.0.1)")
IP2=${IP1#*addr:}
IP=${IP2%% Bcast*}
echo "$IP"

# using grep
ifconfig | grep -Po '(?<=:).*(?=  B)'

# others
ifconfig eth0 | awk -F '[ :]+' 'NR==2 {print $4}'

# Get the internal interface name (for dual NICs with one internal, one external),
# U (route is up) and G (use gateway) flags from 'man route'
route -n | awk '/UG/&&!/0.0.0.0/ {print$NF;exit}'

# Get the external interface name
route -n | awk '/^0.0.0.0/ {print$NF}'

# Get the internal interface IP address (for dual NICs)
ip addr show scope global "$(route -n | awk '/UG/ && ! /0.0.0.0/ {print$NF;exit}')" | awk -F '[ /]+' '/global/ {print $3}'

# Get the external interface IP address
ip addr show scope global "$(ip route | awk '/^default/ {print $5}')" | awk -F '[ /]+' '/global/ {print $3}'
