#!/bin/bash
# ========================================================================
# Script Name:  simple_disk_check.sh
# Description:  Simple Cloud Support Disk Space Monitoring Utility
# Author:       Mohammed Irshad
# ========================================================================

GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0;0m'

echo "=========================================="
echo "📊 SERVER STORAGE & DISK HEALTH AUDIT"
echo "=========================================="

# Check the disk usage of the root filesystem (/)
# Extracting the percentage value safely
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')

echo "Current Root Disk Usage: ${DISK_USAGE}%"

# Simple threshold matching logic
if [ "$DISK_USAGE" -ge 90 ]; then
    echo -e "${RED}[CRITICAL ALERT] Disk space is critically low! Immediate action required.${NC}"
elif [ "$DISK_USAGE" -ge 80 ]; then
    echo -e "${YELLOW}[WARNING] Disk space utilization has exceeded safe threshold.${NC}"
else
    echo -e "${GREEN}[OK] Disk space is within healthy operational parameters.${NC}"
fi

echo "=========================================="
