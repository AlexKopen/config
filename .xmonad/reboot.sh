#!/bin/bash

CHOICE=$(echo -e "No\nYes" | rofi -dmenu -p "Reboot machine?")

TRIMMED_CHOICE=$(echo "$CHOICE" | tr -d '\r\n[:space:]')

if [ "$TRIMMED_CHOICE" = "Yes" ]; then
    reboot
fi
