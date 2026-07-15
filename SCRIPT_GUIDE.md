# SysOps Automation Toolkit Guide

This directory contains production-ready system automation utilities managed by Mohammed Irshad.

## Available Tools

### 1. System Resource Monitor (`sys_resource_monitor.sh`)
* **Purpose:** Monitors live CPU and RAM utilization percentages.
* **Behavior:** Logs system state with timestamps and triggers critical alerts if resource usage crosses the 85% threshold.

### 2. Log to JSON Parser (`log_json_parser.sh`)
* **Purpose:** Parses raw unstructured text logs into structured JSON arrays.
* **Behavior:** Formats operational logs into key-value data models ready for AWS CloudWatch ingestion without requiring root permissions.
