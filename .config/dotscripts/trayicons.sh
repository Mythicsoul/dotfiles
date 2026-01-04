#!/bin/bash

sleep 2 # allowing the tray to start first
# syncthingtray &
# keepassxc &
exec uwsm app -- keepassxc &
