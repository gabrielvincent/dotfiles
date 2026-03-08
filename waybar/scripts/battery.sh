#!/bin/bash

capacity=$(cat /sys/class/power_supply/BAT0/capacity)
status=$(cat /sys/class/power_supply/BAT0/status)
ac_online=$(cat /sys/class/power_supply/AC/online)
power=$(awk '{printf "%.0f", $1/1000000}' /sys/class/power_supply/BAT0/power_now 2>/dev/null || echo "0")

charging_icons=(󰢜 󰂆 󰂇 󰂈 󰢝 󰂉 󰢞 󰂊 󰂋 󰂅)
default_icons=(󰁺 󰁻 󰁼 󰁽 󰁾 󰁿 󰂀 󰂁 󰂂 󰁹)

idx=$(( capacity / 10 ))
(( idx > 9 )) && idx=9

if (( ac_online == 1 )); then
  icon="${charging_icons[$idx]}"
  if [[ "$status" == "Charging" ]]; then
    tooltip="${power}W↑ ${capacity}%"
  else
    tooltip="Plugged ${capacity}%"
  fi
else
  icon="${default_icons[$idx]}"
  tooltip="${power}W↓ ${capacity}%"
fi

if [[ "$status" == "Full" ]]; then
  icon="󰂅"
  tooltip="Full ${capacity}%"
fi

class=""
if (( capacity <= 10 )); then
  class="critical"
elif (( capacity <= 20 )); then
  class="warning"
fi

printf '{"text": "%s", "tooltip": "%s", "class": "%s"}\n' "$icon" "$tooltip" "$class"
