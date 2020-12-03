#!/bin/bash

# Script usage:
# $./volume.sh up vol
# $./volume.sh down vol
# $./volume.sh mute

# Arbitrary but unique message id
msgId="991049"

function get_volume {
    pactl list sinks | grep '^[[:space:]]Volume:' | \
        head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,'
}

function is_mute {
    pacmd list-sinks | awk '/muted/ { print $2 }'
}

function get_sink {
    sink=$(pactl info | grep "Default Sink: ")
    echo "${sink#"Default Sink: "}"
}

# Difference to change volume with
vdiff=$2
function send_notification {
    volume=`get_volume`
    # Calculate number of dashes and spaces
    barsize=10
    dashes=$(($volume / $barsize))
    spaces=$((((100 / $barsize)) - $dashes))
    # Make the bar with special character ─ (not dash -)
    bar1=$(printf "─"'%.s' $(eval "echo {0.."$(($dashes))"}"))
    # Create spaces to make notification size constant
    bar2=$(printf "    "'%.s' $(eval "echo {0.."$(($spaces))"}"))

    # Send the notification
    if [[ "$(is_mute)" == *"yes"* ]]; then
        dunstify -u normal --icon=0 -r "$msgId" "   Volume Muted" "$bar2$bar1"
    else
        dunstify -u normal --icon=0 -r "$msgId" "   Volume $volume%" "$bar2$bar1"
    fi
}

sink=`get_sink`
case $1 in
    up)
        # Up the volume
        volume=`get_volume`
        if [[ $volume -ge 95 ]]; then
            pactl set-sink-volume $sink 100%
        else
            pactl set-sink-volume $sink +$vdiff%
        fi
        send_notification
        ;;
    down)
        pactl set-sink-volume $sink -$vdiff%
	    send_notification
	    ;;
    mute)
    	# Toggle mute
        pactl set-sink-mute $sink toggle
        send_notification
	    ;;
esac
