#!/bin/bash
# ========================================================================
# Description: User-space Log to JSON Parser (No Sudo Required)
# Function:    Scans raw resource logs and parses anomalies/alerts into
#              standard structured JSON blocks for CloudWatch ingestion.
# Author:      Mohammed Irshad
# ========================================================================

LOG_FILE="/home/mdirshad/enterprise-hybrid-core/logs/resource_monitor.log"
JSON_OUT="/home/mdirshad/enterprise-hybrid-core/logs/resource_metrics.json"

# Check if log file exists
if [ ! -f "$LOG_FILE" ]; then
    echo "⚠️ Source log file does not exist yet. Run resource_monitor first!"
    exit 1
fi

echo "[" > "$JSON_OUT"
first_entry=true

# Read line by line and structure it into JSON array
while IFS= read -r line; do
    # Extract timestamp, level, and message details
    if [[ "$line" =~ \[(.*)\]\ (.*) ]]; then
        timestamp="${BASH_REMATCH[1]}"
        rest="${BASH_REMATCH[2]}"
        
        # Determine status level (ALERT vs OK/Starting)
        if [[ "$rest" =~ "🚨 ALERT" ]]; then
            level="CRITICAL"
            message=$(echo "$rest" | sed 's/🚨 ALERT: //')
        elif [[ "$rest" =~ "✅" ]]; then
            level="OK"
            message=$(echo "$rest" | sed 's/✅ //')
        else
            level="INFO"
            message="$rest"
        fi

        # Format as JSON object
        if [ "$first_entry" = true ]; then
            first_entry=false
        else
            echo "," >> "$JSON_OUT"
        fi

        printf "  {\n    \"timestamp\": \"%s\",\n    \"level\": \"%s\",\n    \"message\": \"%s\"\n  }" "$timestamp" "$level" "$message" >> "$JSON_OUT"
    fi
done < "$LOG_FILE"

echo -e "\n]" >> "$JSON_OUT"
echo "✅ Log parsing complete! Parsed data saved in: $JSON_OUT"
