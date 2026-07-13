#!/bin/bash
# ========================================================================
# Description: Live CPU & RAM Performance Monitoring Utility
# Function:    Checks CPU & RAM utilization. Logs high alerts if resources
#              cross the 85% threshold.
# Author:      Mohammed Irshad
# ========================================================================

# Threshold percentage (85%)
THRESHOLD=85
LOG_DIR="/home/mdirshad/enterprise-hybrid-core/logs"
LOG_FILE="$LOG_DIR/resource_monitor.log"

# Create logs directory if it doesn't exist
mkdir -p "$LOG_DIR"

echo "==========================================================" >> "$LOG_FILE"
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Starting System Performance Audit..." | tee -a "$LOG_FILE"

# 1. Check RAM Utilization
MEM_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}' | cut -d. -f1)

if [ "$MEM_USAGE" -gt "$THRESHOLD" ]; then
    echo "🚨 ALERT: High Memory utilization detected! Current: $MEM_USAGE%" | tee -a "$LOG_FILE"
else
    echo "✅ Memory utilization is normal: $MEM_USAGE%" | tee -a "$LOG_FILE"
fi

# 2. Check CPU Utilization
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}' | cut -d. -f1)

if [ "$CPU_USAGE" -gt "$THRESHOLD" ]; then
    echo "🚨 ALERT: High CPU utilization detected! Current: $CPU_USAGE%" | tee -a "$LOG_FILE"
else
    echo "✅ CPU utilization is normal: $CPU_USAGE%" | tee -a "$LOG_FILE"
fi
