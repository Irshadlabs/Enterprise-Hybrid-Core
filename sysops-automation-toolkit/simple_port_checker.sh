#!/bin/bash
# ========================================================================
# Script Name:  simple_port_checker.sh
# Description:  Simple Cloud Support Utility to Check Active Listening Ports
# Author:       Mohammed Irshad
# ========================================================================

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0;0m'

echo "=========================================="
echo "🎯 STARTING CORE SERVICE PORT AUDIT"
echo "=========================================="

# Define the standard infrastructure ports to audit (SSH, HTTP, HTTPS)
PORTS=(22 80 443)

for PORT in "${PORTS[@]}"
do
    # Using 'ss' or 'netstat' pattern simulation via raw socket verification
    # Checking if any service is actively binding to the local port
    if ss -tln | grep -q ":$PORT " > /dev/null 2>&1; then
        echo -e "Port $PORT status: ${GREEN}[LISTENING]${NC} - Service is running safely."
    else
        echo -e "Port $PORT status: ${RED}[CLOSED]${NC} - ALERT: Service down or not bound!"
    fi
done

echo "=========================================="
