#!/bin/bash
# ========================================================================
# Script Name:  simple_log_parser.sh
# Description:  Simple Cloud Support Utility to Filter Errors from Logs
# Author:       Mohammed Irshad
# ========================================================================

RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0;0m'

LOG_FILE="logs/mock_syslog.log"

echo "=========================================="
echo "🔍 STARTING SYSTEM LOG ERROR PARSER"
echo "=========================================="

# Check if log file exists
if [ ! -f "$LOG_FILE" ]; then
    echo -e "${RED}[ERROR] Log file $LOG_FILE not found!${NC}"
    exit 1
fi

echo "Scanning $LOG_FILE for critical anomalies..."
echo "------------------------------------------"

# Simple grep tool execution to filter out ERROR, FAILED, and CRITICAL patterns
# Using -i for case-insensitivity and -E for extended regex parsing
if grep -q -E -i "error|failed|critical" "$LOG_FILE"; then
    echo -e "${YELLOW}The following operational issues were discovered:${NC}\n"
    
    # Highlight lines containing errors
    grep -E -i "error|failed|critical" "$LOG_FILE"
else
    echo -e "${GREEN}[OK] No critical errors or failed events found in this log cycle.${NC}"
fi

echo "=========================================="
