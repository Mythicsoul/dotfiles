#!/usr/bin/env bash


# Switch layout for sonix-usb-device to next
hyprctl switchxkblayout sonix-usb-device next && \
# Send notification with current active layout
notify-send "System" "Keyboard layout set to $(hyprctl -j devices | jq -r '.keyboards[] | select(.name=="sonix-usb-device") | .active_keymap')" -u low
 
