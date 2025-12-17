#!/usr/bin/env bash
# Script to handle monitor detachment in Hyprland
# Called by hyprland-monitor-attached when a monitor is disconnected
# Argument $1 contains the monitor name (e.g., HDMI-A-1, eDP-1)

MONITOR_NAME="$1"

# Log for debugging
echo "[$(date)] Monitor detached: $MONITOR_NAME" >> ~/.config/hypr/scripts/monitor-events.log

# Only act on external monitor (HDMI-A-1) being detached
if [ "$MONITOR_NAME" = "HDMI-A-1" ]; then
    echo "[$(date)] External monitor removed, enabling laptop display (eDP-1)" >> ~/.config/hypr/scripts/monitor-events.log
    # Re-enable the laptop's built-in display with auto positioning
    hyprctl keyword monitor "eDP-1,preferred,auto,1"
    # Restore default single window aspect ratio (unset the limit)
    hyprctl keyword dwindle:single_window_aspect_ratio "1 0"
fi

# Ignore all other monitor events (like eDP-1, FALLBACK)
