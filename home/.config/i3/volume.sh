#!/bin/bash

# Script usage:
# $./volume.sh up vol
# $./volume.sh down vol
# $./volume.sh mute

source $(dirname $0)/message_bar.sh

# Arbitrary but unique message id
msgId="991049"

function get_volume {
    # exclude second match of front-right with extra %
    pactl get-sink-volume "$1" | grep -P -o '[0-9]*(?=%.*%)'
}

function is_mute {
    pactl get-sink-mute "$1" | awk '/Mute: / { print $2 }'
}

function get_default_sink {
    echo "$(pactl get-default-sink)"
}

function get_device_name {
    # get line of with info of current card, and find the first device desription
    # after that line (which is the device name)
    device_code=$(pactl get-default-sink | cut -f2 -d.)
    card_line_number=$(pactl list cards | grep -n "\.${device_code}" | cut -f1 -d: | head -1)
    device_lines=($(pactl list cards | grep -n "device.description" | cut -f1 -d:))
    for device_line in "${device_lines[@]}"; do
        if [ "$device_line" -gt "$card_line_number" ]; then
            echo $(pactl list cards \
                | sed "${device_line}q;d" \
                | grep -o '".*"' \
                | sed 's/"//g')
        fi
    done
}

function send_notification {
    volume=$(get_volume $1)

    device_name=$(get_device_name)

    # Set title
    if [[ "$(is_mute $1)" == *"yes"* ]]; then
        title="Muted (${device_name})"
    else
        title="Volume (${device_name})"
    fi

    send_notification_message_bar "$volume" "$title" "$msgId"
}

sink=`get_default_sink`
vdiff=$2 # Difference to change volume with

case $1 in
    up)
        # Up the volume
        volume=$(get_volume $sink)
        if [[ "$volume" -ge 95 ]]; then
            pactl set-sink-volume "$sink" 100%
        else
            pactl set-sink-volume "$sink" +$vdiff%
        fi
        send_notification $sink
        ;;
    down)
        pactl set-sink-volume "$sink" -$vdiff%
	    send_notification $sink
	    ;;
    mute)
    	# Toggle mute
        pactl set-sink-mute "$sink" toggle
        send_notification $sink
	    ;;
esac
