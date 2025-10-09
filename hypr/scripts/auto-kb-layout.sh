#!/bin/bash

export KB_LAYOUT_US=0
export KB_LAYOUT_US_INTL=1

handle() {
  case $1 in
    activewindow*)
      window_class=$(echo "$1" | awk -F',' '{print $1}' | awk -F'>>' '{print $2}')

      case $window_class in
        *whatsapp*|*WhatsApp*)
          hyprctl switchxkblayout all $KB_LAYOUT_US_INTL
          ;;
        *ghostty*|*slack*|*Slack*|*claude*)
          hyprctl switchxkblayout all $KB_LAYOUT_US
          ;;
      esac
      ;;
  esac
}

nc -U "$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line; do handle "$line"; done
