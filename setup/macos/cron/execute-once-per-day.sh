#!/bin/sh
echo "Send system information"
sysinfo | SUBJECT="[$(hostname)] system information" send-notification

echo "Clean downloads"
clean downloads

echo "Backup system"
backup-system

