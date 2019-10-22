#! /bin/sh

# Script usage:
# ./backlight.sh [up/down] [val]

# Arbitrary but unique message id
msgId="991050"

function get_brightness {
    float=`xbacklight`
    echo ${float%.*}
}

# Difference to change volume with
function send_notification {
    brightness=`get_brightness`
    # Calculate number of dashes and spaces
    barsize=10
    dashes=$(($brightness / $barsize))
    spaces=$((((100 / $barsize)) - $dashes))
    # Make the bar with special character ─ (not dash -)
    bar1=$(printf "─"'%.s' $(eval "echo {0.."$(($dashes))"}"))
    # Create spaces to make notification size constant
    bar2=$(printf "    "'%.s' $(eval "echo {0.."$(($spaces))"}"))

    # Send the notification
    dunstify -u normal --icon="~/Downloads/brightness.png" -r "$msgId" "   Brightness" "$bar2$bar1"
}

if [[ "$1" == "up" ]]; then
    xbacklight -inc $2
else
    xbacklight -dec $2
fi

send_notification
