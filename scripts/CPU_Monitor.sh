#!/bin/bash

# ==========================================================
# Project Name : Linux Server Administration and Automation
# Script Name  : CPU Monitoring Script
# Author       : Huda Zainab
# Purpose      : Monitor CPU usage and identify high CPU load
# ==========================================================

# ------------------ STEP 1: DEFINE VARIABLES ------------------

# Set CPU usage warning threshold
WARNING_THRESHOLD=70

# Set CPU usage critical threshold
CRITICAL_THRESHOLD=90

# Store current date and time
CURRENT_DATE=$(date)

# ------------------ STEP 2: DISPLAY SCRIPT HEADER ------------------

echo "=================================================="
echo "           LINUX SERVER CPU MONITORING"
echo "=================================================="

echo "Script Execution Date: $CURRENT_DATE"

echo ""
echo "Checking CPU usage of the server..."

# ------------------ STEP 3: CHECK SYSTEM INFORMATION ------------------

# Display hostname
HOSTNAME=$(hostname)

echo ""
echo "Server Information:"
echo "Hostname: $HOSTNAME"

# Display number of available CPU cores
CPU_CORES=$(nproc)

echo "Available CPU Cores: $CPU_CORES"

# ------------------ STEP 4: GET CPU USAGE ------------------

# Read CPU idle percentage using top command
CPU_IDLE=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}')

# Calculate actual CPU usage
CPU_USAGE=$(awk -v idle="$CPU_IDLE" 'BEGIN {
    printf "%.2f", 100 - idle
}')

echo ""
echo "CPU Monitoring Details:"
echo "CPU Usage: $CPU_USAGE%"
echo "Warning Threshold: $WARNING_THRESHOLD%"
echo "Critical Threshold: $CRITICAL_THRESHOLD%"

# ------------------ STEP 5: CHECK CPU CONDITIONS ------------------

if [ "$CPU_USAGE" -ge "$CRITICAL_THRESHOLD" ]; then

    echo ""
    echo "CRITICAL ALERT!"
    echo "CPU usage is critically high."
    echo "Immediate server investigation is required."

elif [ "$CPU_USAGE" -ge "$WARNING_THRESHOLD" ]; then

    echo ""
    echo "WARNING ALERT!"
    echo "CPU usage has crossed the warning threshold."
    echo "Please investigate running processes."

else

    echo ""
    echo "STATUS: NORMAL"
    echo "CPU usage is within acceptable limits."

fi

# ------------------ STEP 6: DISPLAY TOP PROCESSES ------------------

echo ""
echo "=================================================="
echo "        TOP 5 CPU CONSUMING PROCESSES"
echo "=================================================="

# Display processes consuming the highest CPU
ps -eo pid,ppid,comm,%cpu,%mem --sort=-%cpu | head -n 6

# ------------------ STEP 7: DISPLAY LOAD AVERAGE ------------------

echo ""
echo "=================================================="
echo "             SYSTEM LOAD AVERAGE"
echo "=================================================="

# Display 1-minute, 5-minute and 15-minute load averages
uptime

# ------------------ STEP 8: DISPLAY CPU CORE INFORMATION ------------------

echo ""
echo "=================================================="
echo "              CPU CORE INFORMATION"
echo "=================================================="

lscpu | grep -E "Architecture|CPU\(s\)|Model name"

# ------------------ STEP 9: SCRIPT COMPLETION ------------------

echo ""
echo "=================================================="
echo "           CPU MONITORING COMPLETED"
echo "=================================================="

echo "Monitoring Date: $(date)"
echo "Server: $HOSTNAME"
echo "Final CPU Usage: $CPU_USAGE%"

echo ""
echo "Linux CPU monitoring script executed successfully."

echo "=================================================="