#!/bin/bash

# ==================================================
# Project Name : Linux Operations Automation
# Script Name  : backup.sh
# Author       : Huda Zainab
# Description  : This script creates automatic backups
#                of project files and stores them in
#                a separate backup directory.
# ==================================================


# Step 1: Define the source directory
# This is the folder containing the files we want to back up.

SOURCE_DIR="/home/devops/academy/project"


# Step 2: Define the backup directory
# All backup files will be stored in this location.

BACKUP_DIR="/home/devops/academy/backup"


# Step 3: Create a timestamp
# This helps us create a unique backup filename every time.

DATE=$(date +"%Y%m%d_%H%M%S")


# Step 4: Define the backup filename
# The backup file will be saved in compressed .tar.gz format.

BACKUP_FILE="project_backup_$DATE.tar.gz"


# Step 5: Display the starting message

echo "================================================"
echo "          LINUX AUTOMATED BACKUP"
echo "================================================"

echo "Backup process started..."
echo "Date and Time: $(date)"


# Step 6: Check whether the source directory exists

if [ ! -d "$SOURCE_DIR" ]; then

    echo "ERROR: Source directory does not exist."
    echo "Please check the source directory path."

    exit 1

else

    echo "Source directory found successfully."

fi


# Step 7: Create backup directory if it does not exist

if [ ! -d "$BACKUP_DIR" ]; then

    echo "Backup directory not found."
    echo "Creating backup directory..."

    mkdir -p "$BACKUP_DIR"

    if [ $? -eq 0 ]; then
        echo "Backup directory created successfully."
    else
        echo "ERROR: Unable to create backup directory."
        exit 1
    fi

else

    echo "Backup directory already exists."

fi


# Step 8: Create the compressed backup

echo "------------------------------------------------"
echo "Creating backup of project files..."
echo "------------------------------------------------"

tar -czf "$BACKUP_DIR/$BACKUP_FILE" -C "$SOURCE_DIR" .


# Step 9: Check whether backup was successful

if [ $? -eq 0 ]; then

    echo "SUCCESS: Backup created successfully!"

else

    echo "ERROR: Backup creation failed."

    exit 1

fi


# Step 10: Verify the backup file

echo "Checking backup file..."

if tar -tzf "$BACKUP_DIR/$BACKUP_FILE" > /dev/null; then

    echo "Backup verification successful."

else

    echo "ERROR: Backup file is corrupted or invalid."

    exit 1

fi


# Step 11: Display backup information

echo "------------------------------------------------"
echo "BACKUP DETAILS"
echo "------------------------------------------------"

echo "Source Directory : $SOURCE_DIR"
echo "Backup Directory : $BACKUP_DIR"
echo "Backup File      : $BACKUP_FILE"

echo "Backup File Size:"

du -h "$BACKUP_DIR/$BACKUP_FILE"


# Step 12: Create a log file

LOG_FILE="$BACKUP_DIR/backup.log"

echo "[$(date)] Backup completed successfully: $BACKUP_FILE" >> "$LOG_FILE"

echo "Backup activity saved in log file."


# Step 13: Display all available backups

echo "------------------------------------------------"
echo "Available Backup Files:"
echo "------------------------------------------------"

ls -lh "$BACKUP_DIR"


# Step 14: Display final message

echo "================================================"
echo "       BACKUP PROCESS COMPLETED"
echo "================================================"

echo "Your project files have been backed up successfully."

exit 0