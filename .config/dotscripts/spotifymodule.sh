#!/usr/bin/env bash

fetch_track_metadata() {

    spotify_status=$(playerctl --player=spotify status)

    local metadata
    metadata=$(playerctl --player=spotify metadata --format  "{{ artist }} - {{ title}}")
        if [[ "$spotify_status" == "Playing" ]]; then
            echo "{\"text\":\"$metadata  \"}"
        else
            echo "{\"text\":\"\"}"
        fi
}

# periodically check current status in case output was not properly updated
periodic_check() {
    while true; do
        check=$(fetch_track_metadata)
        echo "$check"
        sleep 10
    done
}

periodic_check &
    
dbus-monitor --profile | grep --line-buffered -E "PlayPause|Next|Previous|Seeked" | while IFS= read -r 
do
    fetch_track_metadata
done
