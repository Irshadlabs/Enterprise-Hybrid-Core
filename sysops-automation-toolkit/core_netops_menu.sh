#!/bin/bash
# ========================================================================
# Script Name:  core_netops_menu.sh
# Description:  Master Interactive Administrative Dashboard for NetOps
# Author:       Mohammed Irshad (Cloud & Network Engineer)
# ========================================================================

BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0;0m'

while true
do
    clear
    echo -e "${BLUE}===================================================${NC}"
    echo -e " 🌐  ${BLUE}ENTERPRISE HYBRID CORE - OPERATIONS DASHBOARD${NC}"
    echo -e "${BLUE}===================================================${NC}"
    echo -e " 1) Audit Network Connectivity  (Ping Checker)"
    echo -e " 2) Check Cloud Instance Resources (CPU & RAM Health)"
    echo -e " 3) Parse System Active Logs   (Error Filtering)"
    echo -e " 4) Scan Active Listening Ports (Socket Audit)"
    echo -e " 5) Check Root Storage Capacity (Disk Diagnostics)"
    echo -e " 6) Exit Administrative Control Panel"
    echo -e "${BLUE}===================================================${NC}"
    
    echo -n "Select an operational matrix target [1-6]: "
    read CHOICE

    case $CHOICE in
        1)
            echo -e "\nExecuting Network Reachability Check..."
            ./simple_ping_check.sh
            ;;
        2)
            echo -e "\nExecuting Performance Metrics Scan..."
            ./cloud_resource_monitor.sh
            ;;
        3)
            echo -e "\nExecuting Log Anomaly Analysis..."
            ./simple_log_parser.sh
            ;;
        4)
            echo -e "\nExecuting Socket/Port Audit..."
            ./simple_port_checker.sh
            ;;
        5)
            echo -e "\nExecuting Storage Diagnostics..."
            ./simple_disk_check.sh
            ;;
        6)
            echo -e "\n${GREEN}Terminating administrative operational session safely.${NC}"
            break
            ;;
        *)
            echo -e "\n${RED}[INVALID] Selection matched no target infrastructure rules. Try again.${NC}"
            ;;
    esac

    echo -e "\nPress [Enter] key to return back to Master Control Console..."
    read
done
