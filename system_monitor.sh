#!/bin/bash
LOG_FILE="/var/log/system_metrics.log"
ALERT_FILE="/var/log/alerts.log"
THRESHOLD=80

# Get CPU usage (approximation)
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d. -f1)
# Get memory usage
MEM_TOTAL=$(free -m | awk '/Mem:/ {print $2}')
MEM_USED=$(free -m | awk '/Mem:/ {print $3}')
MEM_USAGE=$((MEM_USED * 100 / MEM_TOTAL))

# Log metrics
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
echo "$TIMESTAMP CPU: $CPU_USAGE% MEM: $MEM_USAGE%" >> $LOG_FILE

# Check thresholds and log alerts
if [ $CPU_USAGE -gt $THRESHOLD ] || [ $MEM_USAGE -gt $THRESHOLD ]; then
    echo "$TIMESTAMP ALERT: High usage (CPU: $CPU_USAGE%, MEM: $MEM_USAGE%)" >> $ALERT_FILE
fi
