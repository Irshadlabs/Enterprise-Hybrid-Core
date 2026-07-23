#!/bin/bash
# Description: Automated Port Cleanup Utility for SysOps Operations
# Author: Irshadlabs

PORT=${1:-8080}
PID=$(lsof -t -i:$PORT)

if [ -z "$PID" ]; then
    echo "[INFO] Port $PORT is clean. No active processes found."
else
    echo "[WARNING] Found process $PID holding Port $PORT. Terminating..."
    kill -9 $PID
    echo "[SUCCESS] Port $PORT has been freed successfully."
fi
