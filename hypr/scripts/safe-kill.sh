#!/bin/bash

# Get the active window's class
WINDOW_CLASS=$(hyprctl activewindow -j | jq -r '.class')
WINDOW_TITLE=$(hyprctl activewindow -j | jq -r '.initialTitle')

# Define protected classes (space-separated)
PROTECTED_CLASSES="com.mitchellh.ghostty"

# File to store timestamp
TIMESTAMP_FILE="/tmp/hyprland_safe_kill"

# Check if current window class is protected
if echo "$PROTECTED_CLASSES" | grep -qw "$WINDOW_CLASS"; then
    # Protected window - check for confirmation
    
    if [ -f "$TIMESTAMP_FILE" ]; then
        # File exists, read the timestamp
        STORED_TIMESTAMP=$(cat "$TIMESTAMP_FILE")
        CURRENT_TIMESTAMP=$(date +%s)
        ELAPSED=$((CURRENT_TIMESTAMP - STORED_TIMESTAMP))
        
        if [ "$ELAPSED" -ge 2 ]; then
            # 2+ seconds elapsed, reset and show notification again
            echo "$CURRENT_TIMESTAMP" > "$TIMESTAMP_FILE"
            notify-send "Press Super+W again to confirm kill of $WINDOW_TITLE"
        else
            # Less than 2 seconds elapsed, kill the window
            rm "$TIMESTAMP_FILE"
            hyprctl dispatch killactive
        fi
    else
        # File doesn't exist, create it and show notification
        date +%s > "$TIMESTAMP_FILE"
        notify-send "Press Super+W again to confirm kill of $WINDOW_TITLE"
    fi
else
    # Kill without confirmation for other windows
    hyprctl dispatch killactive
fi
