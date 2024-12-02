#!/bin/bash

# Get the number of active workspaces using hyprctl
active_workspaces=$(hyprctl workspaces | grep -E "ACTIVE" | wc -l)

# Output the active workspace count (you can use this number in Waybar)
echo "{\"text\": \"$active_workspaces\"}"
