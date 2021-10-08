#!/bin/bash

# Script usage:
# $./volume.sh up vol
# $./volume.sh down vol
# $./volume.sh mute

source $(dirname $0)/message_bar.sh

# Arbitrary but unique message id
msgId="991049"

function get_volume {
    pactl get-sink-volume $(get_default_sink) | \
        head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,'
}

function is_mute {
    pacmd list-sinks | awk '/muted/ { print $2 }'
}

function get_default_sink {
    echo "$(pactl get-default-sink)"
}

# Difference to change volume with
vdiff=$2
function send_notification {
    volume=`get_volume`

    # Set title
    if [[ "$(is_mute)" == *"yes"* ]]; then
        title="Volume Muted"
    else
        title="Volume"
    fi

    send_notification_message_bar "$volume" "$title" "$msgId"
}

sink=`get_default_sink`
case $1 in
    up)
        # Up the volume
        volume=`get_volume`
        if [[ $volume -ge 95 ]]; then
            pactl set-sink-volume "$sink" 100%
        else
            pactl set-sink-volume "$sink" +$vdiff%
        fi
        send_notification
        ;;
    down)
        pactl set-sink-volume "$sink" -$vdiff%
	    send_notification
	    ;;
    mute)
    	# Toggle mute
        pactl set-sink-mute "$sink" toggle
        send_notification
	    ;;
esac
