#!/bin/bash

firstHyprlandInstance=$(hyprctl instances -j | jq '.[0].instance' -r)

getGap(){

    if [[ "$direction" = "l" ]]; then
        hyprctl --instance $firstHyprlandInstance getoption general:gaps_out | awk ' /custom/ { print $6 } '

    elif [[ "$direction" = "u" ]]; then
        hyprctl --instance $firstHyprlandInstance getoption general:gaps_out | awk ' /custom/ { print $3 } '

    elif [[ "$direction" = "r" ]]; then
        hyprctl --instance $firstHyprlandInstance getoption general:gaps_out | awk ' /custom/ { print $4 } '

    elif [[ "$direction" = "d" ]]; then
        hyprctl --instance $firstHyprlandInstance getoption general:gaps_out | awk ' /custom/ { print $5 } '
    else
        return 0;
    fi

}

moveActive() {
    local direction=$1

    if [[ "$direction" = "l" ]]; then
        hyprctl --instance $firstHyprlandInstance dispatch movewindow l; hyprctl --instance $firstHyprlandInstance dispatch moveactive "$(getGap $direction)" 0 
    elif [[ "$direction" = "u" ]]; then
        hyprctl --instance $firstHyprlandInstance dispatch movewindow u; hyprctl --instance $firstHyprlandInstance dispatch moveactive 0 "$(getGap $direction)"  
    elif [[ "$direction" = "r" ]]; then
        hyprctl --instance $firstHyprlandInstance dispatch movewindow r; hyprctl --instance $firstHyprlandInstance dispatch moveactive "-$(getGap $direction)" 0 
    elif [[ "$direction" = "d" ]]; then
        hyprctl --instance $firstHyprlandInstance dispatch movewindow d; hyprctl --instance $firstHyprlandInstance dispatch moveactive 0 "-$(getGap $direction)"  
    else
        exit 1;
    fi
}

moveActive $1
