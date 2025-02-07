#!/bin/bash

# Define the directories to be cleaned
TEMP_DIR="/tmp"
CACHE_DIR="$HOME/.cache"
LOG_DIR="$HOME/logs"

# Cleanup Temporary Files
echo "Cleaning up temporary files..."
rm -rf $TEMP_DIR/*

# Cleanup Cache Files (e.g., for various applications)
echo "Cleaning up cache files..."
rm -rf $CACHE_DIR/*

# Cleanup Log Files (if any)
echo "Cleaning up log files..."
rm -rf $LOG_DIR/*.log

# System-wide Temporary Files Cleanup (for Linux)
echo "Cleaning system-wide temporary files..."
sudo rm -rf /var/tmp/*
sudo rm -rf /var/log/*.log

# Additional cleanup commands (like clearing browser cache, etc.)
echo "Cleaning browser cache..."
rm -rf ~/.mozilla/firefox/*.default-release/cache2/*
rm -rf ~/.config/google-chrome/Default/cache/*

# Optionally, clear swap space (not recommended unless necessary)
# sudo swapoff -a
# sudo swapon -a

echo "Cleanup complete!"
