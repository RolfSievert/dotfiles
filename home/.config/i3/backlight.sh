#! /bin/sh

# Script usage:
# ./backlight.sh [up/down] [val]

# Arbitrary but unique message id
msgId="991050"

function get_brightness {
    float=`xbacklight -get`
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
    xbacklight -inc "$2"
elif [[ "$1" == "down" ]]; then
    xbacklight -dec "$2"
elif [[ "$1" == "bright" ]]; then
    display=`xrandr | grep -w connected | cut -f '1' -d ' '`
    xrandr --output $display --brightness "$2"
else
    echo warning: input not recognized
    echo usage: 
    echo -e "\tup, down - increase/decrease brightness"
    echo -e "\tbright - set percieved screen brightness"
    exit
fi

send_notification

# TODO use following to fake brightness above 100%
# xrandr --output output_name --brightness 2
