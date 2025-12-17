#!/usr/bin/env bash
# Script to handle monitor attachment in Hyprland
# Called by hyprland-monitor-attached when a monitor is connected
# Argument $1 contains the monitor name (e.g., HDMI-A-1, eDP-1)

MONITOR_NAME="$1"

# Log for debugging
echo "[$(date)] Monitor attached: $MONITOR_NAME" >> ~/.config/hypr/scripts/monitor-events.log

# Only act on external monitor (HDMI-A-1) being attached
if [ "$MONITOR_NAME" = "HDMI-A-1" ]; then
    echo "[$(date)] External monitor detected, disabling laptop display (eDP-1)" >> ~/.config/hypr/scripts/monitor-events.log
    # Disable the laptop's built-in display
    hyprctl keyword monitor "eDP-1,disable"
    # Limit max width of single windows for ultrawide monitor
    hyprctl keyword dwindle:single_window_aspect_ratio "1 1.05"
fi

# Ignore all other monitor events (like eDP-1, FALLBACK)
