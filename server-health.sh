#!/bin/bash

# ==============================
# Colors
# ==============================

GREEN="\033[32m"
YELLOW="\033[33m"
RED="\033[31m"
RESET="\033[0m"

status_color() {
    case "$1" in
        Normal)
            echo -e "${GREEN}${1}${RESET}"
            ;;
        Warning)
            echo -e "${YELLOW}${1}${RESET}"
            ;;
        Critical)
            echo -e "${RED}${1}${RESET}"
            ;;
    esac
}


# ==============================
# System Information
# ==============================

user=$(whoami)
hostname=$(hostname)
OS=$(source /etc/os-release && echo "$PRETTY_NAME")
uptime=$(uptime -p)


# ==============================
# CPU
# ==============================

idle=$(top -bn1 | grep "%Cpu" | awk '{print $8}')
cpu_usage=$(echo "100 - $idle" | bc)


# ==============================
# Memory
# ==============================

memory_total=$(free -m | awk '/^Mem:/ {print $2}')
memory_available=$(free -m | awk '/^Mem:/ {print $7}')
memory_usage=$(echo "100 - ($memory_available / $memory_total * 100)" | bc -l | xargs printf "%.1f")


# ==============================
# Disk
# ==============================

disk_total=$(df -h / | awk 'NR==2 {print $2}')
disk_used=$(df -h / | awk 'NR==2 {print $3}')
disk_available=$(df -h / | awk 'NR==2 {print $4}')
disk_usage=$(df -h / | awk 'NR==2 {print $5}' | tr -d '%')


# ==============================
# Network
# ==============================

if ping -c 1 8.8.8.8 >/dev/null 2>&1; then
    internet_status="Connected"
    network_status="Normal"
else
    internet_status="Disconnected"
    network_status="Critical"
fi


# ==============================
# Status Calculations
# ==============================

# CPU Status

if (( $(echo "$cpu_usage < 50" | bc -l) )); then
    cpu_status="Normal"
elif (( $(echo "$cpu_usage < 90" | bc -l) )); then
    cpu_status="Warning"
else
    cpu_status="Critical"
fi


# Memory Status

if (( $(echo "$memory_usage < 60" | bc -l) )); then
    memory_status="Normal"
elif (( $(echo "$memory_usage < 80" | bc -l) )); then
    memory_status="Warning"
else
    memory_status="Critical"
fi


# Disk Status

if (( $(echo "$disk_usage < 70" | bc -l) )); then
    disk_status="Normal"
elif (( $(echo "$disk_usage < 90" | bc -l) )); then
    disk_status="Warning"
else
    disk_status="Critical"
fi


# Overall Status

overall_status="Normal"

if [[ "$cpu_status" == "Critical" ||
      "$memory_status" == "Critical" ||
      "$disk_status" == "Critical" ||
      "$network_status" == "Critical" ]]; then

    overall_status="Critical"

elif [[ "$cpu_status" == "Warning" ||
        "$memory_status" == "Warning" ||
        "$disk_status" == "Warning" ||
        "$network_status" == "Warning" ]]; then

    overall_status="Warning"
fi


# ==============================
# Output
# ==============================

echo
echo "========================================"
echo "       LINUX SERVER HEALTH CHECK"
echo "========================================"

echo
echo "System"
echo "----------------------------------------"
echo "Current User   : $user"
echo "Hostname       : $hostname"
echo "OS             : $OS"
echo "Uptime         : $uptime"

echo
echo "CPU"
echo "----------------------------------------"
echo "Usage          : ${cpu_usage}%"
echo "Status         : $(status_color "$cpu_status")"

echo
echo "Memory"
echo "----------------------------------------"
echo "Total          : ${memory_total} MB"
echo "Available      : ${memory_available} MB"
echo "Usage          : ${memory_usage}%"
echo "Status         : $(status_color "$memory_status")"

echo
echo "Disk"
echo "----------------------------------------"
echo "Total          : $disk_total"
echo "Used           : $disk_used"
echo "Available      : $disk_available"
echo "Usage          : ${disk_usage}%"
echo "Status         : $(status_color "$disk_status")"

echo
echo "Services & Applications"
echo "----------------------------------------"

if [ $# -eq 0 ]; then
    echo "No applications specified"
else
    printf "%-14s %-15s %s\n" "Application" "Status" "Path"
    echo "----------------------------------------"

    for app in "$@"
    do
        app_path=$(command -v "$app")

        if [ -n "$app_path" ]; then
            printf "%-14s %-15s %s\n" "$app" "Installed" "$app_path"
        else
            printf "%-14s %-15s %s\n" "$app" "Not Installed" "-"
        fi
    done
fi

echo
echo "Network"
echo "----------------------------------------"
echo "Internet       : $internet_status"
echo "Status         : $(status_color "$network_status")"

echo
echo "========================================"
echo "Overall Status : $(status_color "$overall_status")"
echo "========================================"

























