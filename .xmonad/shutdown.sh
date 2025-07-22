#!/bin/bash

CHOICE=$(echo -e "No\nYes" | rofi -dmenu -p "Shutdown machine?")

TRIMMED_CHOICE=$(echo "$CHOICE" | tr -d '\r\n[:space:]')

if [ "$TRIMMED_CHOICE" = "Yes" ]; then
    systemctl poweroff
fi
