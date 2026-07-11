#!/bin/bash
# Custom wake script - checks lid state, only enables display if lid is open
if cat /proc/acpi/button/lid/LID/state | grep -q "closed"; then
    hyprctl keyword monitor eDP-1, disable
    omarchy-brightness-keyboard restore
else
    omarchy-brightness-display on
    omarchy-brightness-keyboard restore
fi
