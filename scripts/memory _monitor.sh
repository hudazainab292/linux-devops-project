#!/bin/bash

# ==========================================================
# Project Name : Linux Server Administration and Automation
# Script Name  : Memory Monitoring Script
# Author       : Huda Zainab
# Purpose      : Monitor RAM usage and generate alerts
# ==========================================================


# ------------------ STEP 1: DEFINE VARIABLES ------------------

# Set memory usage thresholds
WARNING_THRESHOLD=70
CRITICAL_THRESHOLD=90

# Store current date and time
CURRENT_DATE=$(date)


# ------------------ STEP 2: DISPLAY SCRIPT HEADER ------------------

echo "=================================================="
echo "          LINUX SERVER MEMORY MONITORING"
echo "=================================================="

echo "Execution Date: $CURRENT_DATE"


# ------------------ STEP 3: SERVER INFORMATION ------------------

HOSTNAME=$(hostname)

echo ""
echo "Server Information:"
echo "Hostname: $HOSTNAME"


# ------------------ STEP 4: CHECK MEMORY INFORMATION ------------------

# Get total memory in MB
TOTAL_MEMORY=$(free -m | awk '/Mem:/ {print $2}')

# Get used memory in MB
USED_MEMORY=$(free -m | awk '/Mem:/ {print $3}')

# Get available memory in MB
AVAILABLE_MEMORY=$(free -m | awk '/Mem:/ {print $7}')

# Calculate memory usage percentage
MEMORY_USAGE=$(awk -v used="$USED_MEMORY" -v total="$TOTAL_MEMORY" \
'BEGIN {
    if (total > 0)
        printf "%.2f", (used / total) * 100
    else
        print "0"
}')


# ------------------ STEP 5: DISPLAY MEMORY DETAILS ------------------

echo ""
echo "Memory Usage Details:"

echo "Total Memory     : ${TOTAL_MEMORY} MB"
echo "Used Memory      : ${USED_MEMORY} MB"
echo "Available Memory : ${AVAILABLE_MEMORY} MB"
echo "Memory Usage     : ${MEMORY_USAGE}%"

echo ""
echo "Warning Threshold : ${WARNING_THRESHOLD}%"
echo "Critical Threshold: ${CRITICAL_THRESHOLD}%"


# ------------------ STEP 6: CHECK MEMORY CONDITIONS ------------------

if awk -v usage="$MEMORY_USAGE" -v limit="$CRITICAL_THRESHOLD" \
'BEGIN {exit !(usage >= limit)}'; then

    echo ""
    echo "CRITICAL ALERT!"
    echo "Memory usage is critically high."
    echo "Immediate investigation is required."

elif awk -v usage="$MEMORY_USAGE" -v limit="$WARNING_THRESHOLD" \
'BEGIN {exit !(usage >= limit)}'; then

    echo ""
    echo "WARNING ALERT!"
    echo "Memory usage has crossed the warning threshold."
    echo "Please investigate memory-consuming applications."

else

    echo ""
    echo "STATUS: NORMAL"
    echo "Memory usage is within acceptable limits."

fi


# ------------------ STEP 7: DISPLAY TOP MEMORY PROCESSES ------------------

echo ""
echo "=================================================="
echo "       TOP 5 MEMORY CONSUMING PROCESSES"
echo "=================================================="

# Display processes consuming the highest memory
ps -eo pid,ppid,comm,%mem,rss --sort=-%mem | head -n 6


# ------------------ STEP 8: DISPLAY SWAP INFORMATION ------------------

echo ""
echo "=================================================="
echo "                SWAP INFORMATION"
echo "=================================================="

# Display swap memory usage
free -h | grep -i Swap


# ------------------ STEP 9: DISPLAY MEMORY SUMMARY ------------------

echo ""
echo "=================================================="
echo "              MEMORY SUMMARY"
echo "=================================================="

free -h


# ------------------ STEP 10: SCRIPT COMPLETION ------------------

echo ""
echo "=================================================="
echo "         MEMORY MONITORING COMPLETED"
echo "=================================================="

echo "Server Name: $HOSTNAME"
echo "Total Memory: ${TOTAL_MEMORY} MB"
echo "Memory Usage: ${MEMORY_USAGE}%"

echo ""
echo "Linux memory monitoring script executed successfully."

echo "=================================================="