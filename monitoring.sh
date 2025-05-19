#!/bin/bash

arch=$(uname -a)
pcpu=$(grep "physical id" /proc/cpuinfo | sort | uniq | wc -l)
vcpu=$(grep processor /proc/cpuinfo | sort | uniq | wc -l)
ram_total=$(free --mega | grep Mem | awk '{print $2}')
ram_used=$(free --mega | grep Mem | awk '{print $3}')
ram_perc=$(free --mega | grep Mem | awk '{printf("%.2f%%", $3 / $2 * 100)}') 
disk_total=$(df -h --total | grep total | awk '{print $2}')
disk_used=$(df -h --total | grep total | awk '{print $3}')
disk_perc=$(df -h --total | grep total | awk '{print $5}')
cpu_load=$(top -bn1 | grep '^%Cpu' | awk '{printf("%.1f%%", $2 + $4)}')
last_boot=$(who -b | awk '{print $3 " " $4}')
lvm=$(if lsblk | grep -q lvm; then echo yes; else echo no; fi)
tcp=$(grep TCP /proc/net/sockstat | awk '{print $3}')
ulog=$(who | awk '{print $1}' | sort | uniq | wc -l)
ip=$(hostname -I | awk '{print $1}')
mac=$(ip link | grep link/ether | awk '{print $2}')
cmd=$(grep COMMAND /var/log/sudo/sudo.log | wc -l)

wall "Architecture:      $arch
Physical CPU:    $pcpu
Virtual CPU:     $vcpu
Memory usage:    $ram_used/${ram_total}MB ($ram_perc)
Disk usage:      $disk_used/$disk_total ($disk_perc)
CPU load:        $cpu_load
Last boot:       $last_boot
LVM use:         $lvm
Connections TCP: $tcp established
User log:        $ulog
Network:         $ip ($mac)
Sudo:            $cmd commands used"