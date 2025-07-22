#!/bin/bash

CHOICE=$(echo -e "No\nYes" | rofi -dmenu -p "Lock the screen?")

TRIMMED_CHOICE=$(echo "$CHOICE" | tr -d '\r\n[:space:]')

if [ "$TRIMMED_CHOICE" = "Yes" ]; then
    i3lock-fancy
fi
