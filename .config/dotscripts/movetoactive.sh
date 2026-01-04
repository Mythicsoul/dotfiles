#!/usr/bin/env bash
 
echo -e "\0prompt\x1fSummon Window: "

if [ -z "$ROFI_INFO" ]; then
  hyprctl clients -j | jq -r '.[] | "\(.class) — \(.title)\u0000info\u001f\(.address)"'
else
  WINDOW_ADDRESS=$(printf '%s\n' "$ROFI_INFO" | awk -F $'\x1f' '{print $NF}' | tr -d '[:space:]')
  WORKSPACE_ID=$(hyprctl activeworkspace -j | jq -r '.id')
  hyprctl dispatch movetoworkspace "$WORKSPACE_ID,address:$WINDOW_ADDRESS" >/dev/null 2>&1
  hyprctl dispatch focuswindow address:"$WINDOW_ADDRESS" >/dev/null 2>&1 &
fi



