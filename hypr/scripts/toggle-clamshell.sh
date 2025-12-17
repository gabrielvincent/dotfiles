#!/usr/bin/env bash
# Toggle between clamshell mode (external Samsung only) and normal mode (laptop display enabled)

SAMSUNG_NAME="HDMI-A-1"
LAPTOP_NAME="eDP-1"

# Check if Samsung monitor is connected
external_connected=$(hyprctl monitors | grep -i "$SAMSUNG_NAME")
# Check current state of laptop display
laptop_disabled=$(hyprctl monitors -j | jq -r '.[] | select(.description | contains("Lenovo Group Limited B140UAN02.7")) | .disabled' 2>/dev/null)

if [ -z "$external_connected" ]; then
    echo "External monitor not detected. Enabling laptop display only."
    hyprctl keyword monitor "$LAPTOP_NAME,1920x1200@60,0x0,1"
    notify-send "Display Mode" "Laptop display enabled" -t 2000
    exit 0
fi


if [ "$laptop_disabled" = "true" ] || [ -z "$laptop_disabled" ]; then
    # Laptop is currently disabled or not found, enable it (dual display mode)
    echo "Enabling dual display mode"
    hyprctl keyword monitor "$SAMSUNG_NAME,3840x2160@60,0x0,1"
    hyprctl keyword monitor "$LAPTOP_NAME,1920x1200@60,3840x0,1"
    notify-send "Display Mode" "Dual display enabled" -t 2000
else
    # Laptop is currently enabled, disable it (clamshell mod    echo "Enabling clamshell mode (Samsung only)"
    hyprctl keyword monitor "$SAMSUNG_NAME,3840x2160@60,0x0,1"
    hyprctl keyword monitor "$LAPTOP_NAME,disable"
    notify-send "Display Mode" "Clamshell mode" -t 2000
fi
