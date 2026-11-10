# !/bin/bash 


# Linux Automated Backup Script

SOURCE_DIR="/home/devops/project"
BACKUP_DIR="/home/devops/backups"

DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="project_backup_$DATE.tar.gz"

echo "================================"
echo "Starting Linux Backup Process"
echo "================================"

# Check source directory
if [ ! -d "$SOURCE_DIR" ]; then
    echo "ERROR: Source directory not found!"
    exit 1
fi

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Create compressed backup
tar -czf "$BACKUP_DIR/$BACKUP_FILE" -C "$SOURCE_DIR" .

# Check backup status
if [ $? -eq 0 ]; then
    echo "Backup completed successfully!"
    echo "Backup file: $BACKUP_FILE"
else
    echo "ERROR: Backup failed!"
    exit 1
fi

echo "================================"
echo "Backup process finished"
echo "================================"

# Linux Automated Backup Script

SOURCE_DIR="$HOME/project"
BACKUP_DIR="$HOME/backups"

DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="project_backup_$DATE.tar.gz"

echo "================================"
echo "   LINUX AUTOMATED BACKUP"
echo "================================"