#!/bin/bash

CHOICE=$(echo -e "No\nYes" | rofi -dmenu -p "Logout user?")

TRIMMED_CHOICE=$(echo "$CHOICE" | tr -d '\r\n[:space:]')

if [ "$TRIMMED_CHOICE" = "Yes" ]; then
    loginctl terminate-user $USER
fi
