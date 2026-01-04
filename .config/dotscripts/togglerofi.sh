#!/bin/bash

if pgrep -x "rofi" > /dev/null
then
  pkill rofi
else
  rofi -show drun -run-command "uwsm app -- {cmd}" &
fi
