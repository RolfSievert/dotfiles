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

function send_notification {
    volume=$(get_volume $1)

    # Set title
    if [[ "$(is_mute $1)" == *"yes"* ]]; then
        title="Volume Muted"
    else
        title="Volume"
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
