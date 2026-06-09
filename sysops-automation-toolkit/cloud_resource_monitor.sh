#!/bin/bash
# ========================================================================
# Script Name:  cloud_resource_monitor.sh
# Description:  Simple Cloud Support Resource Utilization Watchdog
# Author:       Mohammed Irshad
# ========================================================================

GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0;0m'

echo "=========================================="
echo "⚡ CLOUD INSTANCE RESOURCE HEALTH AUDIT"
echo "=========================================="

# 1. Capture CPU Utilization (Extracting idle time from top and subtracting from 100)
CPU_IDLE=$(top -b -n 1 | grep "Cpu(s)" | awk '{print $8}' | cut -d. -f1)
CPU_USAGE=$((100 - CPU_IDLE))

# 2. Capture Memory (RAM) Utilization percentage
MEM_USAGE=$(free | grep Mem | awk '{print int($3/$2 * 100)}')

echo -e "Current CPU Utilization:    ${CPU_USAGE}%"
echo -e "Current Memory Utilization: ${MEM_USAGE}%"
echo "------------------------------------------"

# --- RESOURCE METRIC VALIDATION LOGIC ---
if [ "$CPU_USAGE" -ge 85 ] || [ "$MEM_USAGE" -ge 85 ]; then
    echo -e "${RED}[CRITICAL] High Resource Spike Detected! Check running microservices.${NC}"
elif [ "$CPU_USAGE" -ge 70 ] || [ "$MEM_USAGE" -ge 70 ]; then
    echo -e "${YELLOW}[WARNING] Instance metrics are rising beyond standard thresholds.${NC}"
else
    echo -e "${GREEN}[OK] Systems computational infrastructure is working stable.${NC}"
fi

echo "=========================================="
