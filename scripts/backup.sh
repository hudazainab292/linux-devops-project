#!/bin/bash

# Linux Automated Backup Script

SOURCE_DIR="$HOME/project"
BACKUP_DIR="$HOME/backups"

DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="project_backup_$DATE.tar.gz"

echo "================================"
echo "   LINUX AUTOMATED BACKUP"
echo "================================"

# Check source directory

if [ ! -d "$SOURCE_DIR" ]; then
    echo "ERROR: Source directory does not exist!"
    exit 1
fi

# Create backup directory

mkdir -p "$BACKUP_DIR"

# Create compressed backup

tar -czf "$BACKUP_DIR/$BACKUP_FILE" -C "$HOME" project

# Check backup status

if [ $? -eq 0 ]; then
    echo "Backup completed successfully!"
    echo "Backup file: $BACKUP_FILE"
    echo "Backup location: $BACKUP_DIR"
else
    echo "ERROR: Backup failed!"
    exit 1
fi

echo "================================"