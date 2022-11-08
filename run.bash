#!/usr/bin/env bash

script_path=$(dirname $(realpath "$0"))

title="Stand up!"
subtitle="Blood needs to flow 🧍"
body="One hour has passed and still sitting? Cmon, up and exercise!"
replace_notification_id=0
icon_data="0"
actions='[]'
hints='{}'
expire_timeout=0
sound_path="$script_path/sounds/service-login.oga"

guid=1000

export XDG_RUNTIME_DIR="/run/user/$guid"

function send_notification() {
    gdbus call --session \
        --dest=org.freedesktop.Notifications \
        --object-path=/org/freedesktop/Notifications \
        --method=org.freedesktop.Notifications.Notify \
        "$title" "$replace_notification_id" "$icon_data" "$subtitle" "$body" \
        $actions "$hints" $expire_timeout
}

function play_sound() {
    command=paplay
    
    if [[ -x "$(command -v $command)" ]]
    then
        $command "$sound_path"
    fi
}

send_notification & play_sound
