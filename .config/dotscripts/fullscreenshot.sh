#!/bin/bash

grim -g "0,0 3840x1080" "$HOME/Pictures/Screenshots/$(date +'full-%F_%H-%M-%S.png')" && \
notify-send -u low System "Screenshot captured" && \
wl-copy < $HOME/Pictures/Screenshots/$(ls -t $HOME/Pictures/Screenshots/ | head -n 1)

