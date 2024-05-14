#!/bin/bash
sleep 0.1
exec rofi -show menu -modi "menu:rofi-power-menu --choices=shutdown/reboot/logout"

# launch rofi power menu
