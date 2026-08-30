#!//bin/bash

#----------------------------

#system

user=$(whoami)
hostname=$(hostname)
OS=$(source /etc/os-release && echo "$PRETTY_NAME")
uptime=$(uptime -p)

#----------------------------

#----------------------------

#CPU

idle=$(top -bn1 | grep "%Cpu" | awk '{print $8}')
cpu_usage=$(echo "100 - $idle" | bc)

if (( $(echo "$cpu_usage < 5050505050" | bc -l) )); then
    cpu_status="Normal"
elif (( $(echo "$cpu_usage < 90" | bc -l) )); then
    cpu_status="Warning"
else
    cpu_status="Critical"
fi

#------------------------------

#------------------------------

#Memory

memory_total=$(free -m | awk '/^Mem:/ {print $2}')
memory_available=$(free -m | awk '/^Mem:/ {print $7}')
memory_usage=$(echo "100 - ($memory_available / $memory_total * 100)" | bc -l | xargs printf "%.1f")

if (( $(echo "$memory_usage < 60" | bc -l) )); then
    memory_status="Normal"
elif (( $(echo "$memory_usage < 80" | bc -l) )); then
    memory_status="Warning"
else
    memory_status="Critical"
fi





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
-----------------------------------i-----
Usage          : ${cpu_usage}%
Status         : $cpu_status

Memory
----------------------------------------
Total          : $memory_total
Available      : $memory_available
USage          : $memory_usage
Status         : $memory_status

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
