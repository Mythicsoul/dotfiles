#!/bin/bash

getGap(){
     hyprctl getoption general:gaps_out -j | jq '.int'
}

moveActive() {
    local direction=$1

    if [[ "$direction" = "l" ]]; then
        hyprctl dispatch movewindow l; hyprctl dispatch moveactive "$(getGap $direction)" 0 
    elif [[ "$direction" = "u" ]]; then
        hyprctl  dispatch movewindow u; hyprctl dispatch moveactive 0 "$(getGap $direction)"  
    elif [[ "$direction" = "r" ]]; then
        hyprctl dispatch movewindow r; hyprctl dispatch moveactive "-$(getGap $direction)" 0 
    elif [[ "$direction" = "d" ]]; then
        hyprctl dispatch movewindow d; hyprctl dispatch moveactive 0 "-$(getGap $direction)"  
    else
        exit 1;
    fi
}


moveActive $1
