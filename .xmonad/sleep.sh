#!/bin/bash

CHOICE=$(echo -e "No\nYes" | rofi -dmenu -p "Go to sleep?")

TRIMMED_CHOICE=$(echo "$CHOICE" | tr -d '\r\n[:space:]')

if [ "$TRIMMED_CHOICE" = "Yes" ]; then
    systemctl suspend && i3lock-fancy
fi
