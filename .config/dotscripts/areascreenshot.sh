#!/bin/bash

grim -g "$(slurp -d)" "$HOME/Pictures/Screenshots/$(date +'area-%F_%H-%M-%S.png')" && \
notify-send -u low System "Screenshot captured" && \
wl-copy < $HOME/Pictures/Screenshots/$(ls -t $HOME/Pictures/Screenshots/ | head -n 1)
