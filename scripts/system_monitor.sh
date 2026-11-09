#!/bin/bash

# Linux Server Monitoring Script

echo "================================"
echo "     LINUX SERVER MONITOR"
echo "================================"

echo ""
echo "1. HOSTNAME"
hostname

echo ""
echo "2. SYSTEM UPTIME"
uptime

echo ""
echo "3. CPU INFORMATION"
top -bn1 | head -5

echo ""
echo "4. MEMORY USAGE"
free -h

echo ""
echo "5. DISK USAGE"
df -h

echo ""
echo "================================"
echo " Monitoring Completed Successfully"
echo "================================"