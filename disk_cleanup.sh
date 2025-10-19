#!/bin/bash

# -----------------------------
# Linux Disk Cleanup Tool
# Author: Adarsh Shivan
# -----------------------------

LOGFILE="/home/adarsh/linux-projects/linux-disk-cleanup/cleanup.log"
DATE=$(date "+%Y-%m-%d %H:%M:%S")

echo "----------------------------------------" >> $LOGFILE
echo "Cleanup started at: $DATE" >> $LOGFILE

# Function to check and clean directory safely
clean_directory() {
    DIR=$1
    DESCRIPTION=$2

    if [ -d "$DIR" ]; then
        echo "Cleaning $DESCRIPTION ($DIR)..."
        echo "Cleaning $DESCRIPTION ($DIR)..." >> $LOGFILE
        sudo find "$DIR" -type f -name "*.log" -o -name "*.tmp" -o -name "*.cache" -delete 2>/dev/null
        echo "Done cleaning $DESCRIPTION." >> $LOGFILE
    else
        echo "$DESCRIPTION not found. Skipping..." >> $LOGFILE
    fi
}

# Clean system and user temp files
clean_directory "/tmp" "System Temporary Files"
clean_directory "$HOME/.cache" "User Cache"
clean_directory "/var/log" "System Log Files"

# Optional: Clean Trash if present
TRASH="$HOME/.local/share/Trash/files"
if [ -d "$TRASH" ]; then
    echo "Cleaning Trash directory..."
    rm -rf "$TRASH"/* 2>/dev/null
    echo "Trash cleaned." >> $LOGFILE
fi

# Show disk usage summary
echo "Disk space before and after cleanup:" >> $LOGFILE
df -h | grep -E "Filesystem|/dev/sd|/dev/nvme" >> $LOGFILE

END_DATE=$(date "+%Y-%m-%d %H:%M:%S")
echo "Cleanup completed at: $END_DATE" >> $LOGFILE
echo "----------------------------------------" >> $LOGFILE

echo "✅ Disk cleanup completed successfully. Log saved to: $LOGFILE"

