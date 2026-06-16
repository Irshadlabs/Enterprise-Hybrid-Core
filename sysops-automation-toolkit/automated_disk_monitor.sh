#!/bin/bash
# ========================================================================
# Description: Automated Production Disk Space Monitoring & Alerting Utility
# Threshold:   Triggers Critical Alert if disk usage crosses 90%
# Author:      Mohammed Irshad
# ========================================================================

# 1. Threshold definition (90% Storage Capacity)
THRESHOLD=90

# 2. Extract current disk utilization of the root filesystem (/)
CURRENT_USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')

# 3. Target log location for infrastructure diagnostics
LOG_FILE="/home/mdirshad/enterprise-hybrid-core/logs/disk_monitor_ops.log"

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Initializing Disk Space Storage Audit..."

# 4. Core Alert Logic
if [ "$CURRENT_USAGE" -gt "$THRESHOLD" ]; then
    echo "=============================================================="
    echo "🚨 CRITICAL ALERT: ROOT DISK STORAGE IS BREACHING PERFORMANCE LIMITS!"
    echo "Current Utilization: ${CURRENT_USAGE}% (Threshold: ${THRESHOLD}%)"
    echo "=============================================================="
    
    # Logging the alert into the operational vector
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] CRITICAL - Storage utilization is at ${CURRENT_USAGE}%" >> $LOG_FILE 2>/dev/null
else
    echo "✅ SYSTEM HEALTH OK: Disk storage is operating within normal parameters (${CURRENT_USAGE}% utilized)."
fi
