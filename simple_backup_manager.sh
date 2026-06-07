#!/bin/bash
# ========================================================================
# Script Name:  simple_backup_manager.sh
# Description:  Simple Cloud Support Utility for Configuration Backups
# Author:       Mohammed Irshad
# ========================================================================

GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0;0m'

# Define target directories (Safe structure inside repository)
SOURCE_DIR="cisco-packet-tracer-labs"
BACKUP_DIR="backups"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="$BACKUP_DIR/cisco_config_backup_$TIMESTAMP.tar.gz"

echo "=========================================="
echo "💾 STARTING CONFIGURATION BACKUP MANAGER"
echo "=========================================="

# Ensure backup destination folder exists
mkdir -p "$BACKUP_DIR"

# Verify if the source directory is present
if [ ! -d "$SOURCE_DIR" ]; then
    echo -e "${RED}[ERROR] Source directory $SOURCE_DIR does not exist!${NC}"
    exit 1
fi

echo "Compressing configuration assets from: $SOURCE_DIR..."

# Create a zipped tar archive safely
tar -czf "$BACKUP_FILE" "$SOURCE_DIR"

if [ $? -eq 0 ]; then
    echo -e "${GREEN}[SUCCESS] Backup archive created successfully!${NC}"
    echo -e "Archive Saved As: $BACKUP_FILE"
else
    echo -e "${RED}[ERROR] Failed to create backup archive.${NC}"
    exit 1
fi

# --- AUTOMATIC RETENTION & PURGE LOGIC (7 DAYS RUN) ---
echo -e "\nRunning storage optimization control..."
echo "Scanning for archives older than 7 days to purge..."

# Find and delete files older than 7 days inside the backup folder
find "$BACKUP_DIR" -type f -name "*.tar.gz" -mtime +7 -exec rm {} \;

echo -e "${GREEN}[OK] Retention cycle complete. Storage optimized safely.${NC}"
echo "=========================================="
