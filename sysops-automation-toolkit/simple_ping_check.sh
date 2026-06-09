#!/bin/bash
# ========================================================================
# Script Name:  simple_ping_check.sh
# Description:  Simple Cloud Support Network Connectivity Tester
# Author:       Mohammed Irshad
# ========================================================================

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0;0m'

echo "=========================================="
echo "⚡ QUICK NETWORK CONNECTIVITY CHECK"
echo "=========================================="

# List of highly reliable public endpoints to test network heartbeat
SERVERS=("8.8.8.8" "1.1.1.1" "aws.amazon.com")

for TARGET in "${SERVERS[@]}"
do
    echo -n "Testing connection to $TARGET... "
    
    # Ping the target 2 times with a 2-second timeout
    if ping -c 2 -W 2 $TARGET > /dev/null 2>&1; then
        echo -e "${GREEN}[OK] Connected${NC}"
    else
        echo -e "${RED}[FAILED] Unreachable${NC}"
    fi
done

echo "=========================================="
