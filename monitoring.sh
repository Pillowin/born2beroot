#! /usr/bin/env bash

arch=`uname --all`

cpu=`lscpu | grep "^Socket(s)" | awk '{printf("%s\n", $2)}'`

vcpu=`nproc`

mem=`free --human | grep "^Mem:" | awk '{printf("%s/%s ", $3, $2)}'`
mem+=`free | grep "^Mem:" | awk '{printf("(%.2f%%)\n"), $3 / $2 * 100}'`

du=`df --human-readable --total | grep "^total" | awk '{printf("%s/%s (%s)\n", $3, $2, $5)}'`

load=`top -b -n 1 | grep "^%Cpu(s):" | awk '{printf("%s%%\n", $4)}'`

boot=`who --boot | awk '{printf("%s %s\n", $3, $4)}'`

if [ `lsblk --output "type" | grep "lvm" | wc -l` -ge 1 ]
then
	lvm="yes"
else
	lvm="no"
fi

tcp=`ss --summary | grep "^TCP:" | awk '{printf("%s", $4)}' |  tr --delete ','`

user=`users | wc -w`

ip=`hostname --all-ip-address`
ip+=`ip addr show | grep ether | awk '{printf("(%s)\n", $2)}'`

sudo=`grep -c "COMMAND=" /var/log/sudo/sudo.log`

wall <<< "#Architecture: $arch
#CPU physical: $cpu
#vCPU: $vcpu
#Memory Usage: $mem
#Disk Usage: $du
#CPU load: $load
#Last boot: $boot
#LVM use: $lvm
#Connections TCP: $tcp ESTABLISHED
#User log: $user
#Network: $ip
#Sudo: $sudo cmd"
