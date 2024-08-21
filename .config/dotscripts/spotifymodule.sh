#!/usr/bin/env bash

fetch_track_metadata() {

    spotify_status=$(playerctl --player=spotify status)

    local metadata
    metadata=$(playerctl --player=spotify metadata --format  "{{ artist }} - {{ title}}")
        if [[ "$spotify_status" == "Playing" ]]; then
        echo "{\"text\":\"$metadata \"}"
    else
        echo "{\"text\":\"paused \"}"
    fi
}

current_track=$(fetch_track_metadata)
echo "$current_track"
previous_track="$current_track"


dbus-monitor --profile | grep --line-buffered -E "PlayPause|Next|Previous|Seeked" | while IFS= read -r; do
            current_track=$(fetch_track_metadata)
            if  [[ $current_track != "$previous_track" ]]; then
                echo "$current_track"
                previous_track=$current_track
            fi
done
