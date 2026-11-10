#!/bin/bash

# Project: Linux Server Administration and Automation
# Script: Log Cleanup Automation
# Purpose: Identify and remove log files older than 7 days
# Author: Huda Zainab

# Define variables
LOG_DIR="./logs"
RETENTION_DAYS=7
LOG_FILE="./logs/cleanup.log"

# Display project information
echo "=========================================="
echo "       LINUX LOG CLEANUP AUTOMATION"
echo "=========================================="

echo "Execution Date: $(date)"
echo "Log Directory: $LOG_DIR"
echo "Retention Period: $RETENTION_DAYS days"

# Check whether the log directory exists
if [ ! -d "$LOG_DIR" ]; then
    echo "ERROR: Log directory does not exist."
    exit 1
fi

# Create a log file if it does not exist
touch "$LOG_FILE"

echo ""
echo "Starting log cleanup process..."

# Find log files older than retention period
OLD_FILES=$(find "$LOG_DIR" -type f -name "*.log" ! -name "cleanup.log" -mtime +"$RETENTION_DAYS")

# Check whether old log files are available
if [ -z "$OLD_FILES" ]; then
    echo "No old log files found."
    echo "$(date): No old files found." >> "$LOG_FILE"
else

    echo "Old log files identified:"
    echo "$OLD_FILES"

    # Delete old log files
    find "$LOG_DIR" -type f -name "*.log" ! -name "cleanup.log" -mtime +"$RETENTION_DAYS" -delete

    echo "Old log files deleted successfully."
    echo "$(date): Old log files cleaned successfully." >> "$LOG_FILE"

fi

# Display remaining log files
echo ""
echo "Remaining log files:"
find "$LOG_DIR" -type f -name "*.log"

echo ""
echo "Log cleanup process completed."

echo "=========================================="
echo "          SCRIPT COMPLETED"
echo "=========================================="