#!/bin/bash
# Check if any tray icons exist by looking for tray windows
if [ -n "$(hyprctl clients -j | jq -r '.[] | select(.class | startswith("tray")) | .class')" ]; then
    echo " | "
else
    echo ""
fi