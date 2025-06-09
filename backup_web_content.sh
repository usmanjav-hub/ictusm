#!/bin/bash
# Website Backup Script for ICT171 Assignment
# Purpose: Automatically backs up web content and Apache config

# Configuration
BACKUP_DIR="/var/backups/website"
LOG_FILE="/var/log/website_backup.log"
WEB_ROOT="/var/www/html"
APACHE_CONF="/etc/apache2"
KEEP_BACKUPS=7

# Create backup directory if missing
mkdir -p "$BACKUP_DIR"

# Generate timestamp
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="$BACKUP_DIR/backup_$TIMESTAMP.tar.gz"

# Perform backup
echo "$(date) - Starting backup" >> "$LOG_FILE"
tar -czf "$BACKUP_FILE" "$WEB_ROOT" "$APACHE_CONF" 2>> "$LOG_FILE"

# Clean old backups
ls -t "$BACKUP_DIR"/backup_*.tar.gz | tail -n +$(($KEEP_BACKUPS + 1)) | xargs rm -f

# Verify and log
if [ -f "$BACKUP_FILE" ]; then
    echo "$(date) - Backup successful: $BACKUP_FILE" >> "$LOG_FILE"
else
    echo "$(date) - Backup failed!" >> "$LOG_FILE"
fi