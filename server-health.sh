#!//bin/bash

#----------------------------

#system

user=$(whoami)
hostname=$(hostname)
OS=$(uname)
uptime=$(uptime)

#----------------------------

#----------------------------

#CPU

usage=$(top -bn1 | awk '/Cpu\(s\)/ {print $2}')
sstatus=$(mpstat 1 1)






echo "
========================================
       LINUX SERVER HEALTH CHECK
========================================

System
----------------------------------------
Current User   : $user 
Hostname       : $hostname 
OS             : $OS 
Uptime         : $uptime

CPU
----------------------------------------
Usage          :$usage
Status         :$cstatus

Memory
----------------------------------------
Used           :
Usage          : 
Status         : 

Disk
----------------------------------------
/              : 
Status         : 

Services
----------------------------------------
nginx          : 
mongodb        : 
docker         : 

Network
----------------------------------------
Internet       : 

========================================
Overall Status: WARNING
========================================   

"
