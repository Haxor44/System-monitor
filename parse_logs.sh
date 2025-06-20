#!/bin/bash
LOG_FILE="/var/log/system_metrics.log"

# Extract alerts
grep "ALERT" $LOG_FILE > high_usage.log
# Summarize timestamps and metrics
awk '/ALERT/{print $1, $2, $5, $7}' $LOG_FILE > summary.txt
