#! /bin/sh

# Script usage:
# ./backlight.sh [up/down] [val]

source $(dirname $0)/message_bar.sh

# Arbitrary but unique message id
msgId="991050"

function get_brightness_percentage {
    current=$(brightnessctl get)
    max=$(brightnessctl max)
    float=$((100 * current / max))
    echo ${float%.*}
}

function get_display_name {
    echo $(xrandr | grep -w connected | cut -f '1' -d ' ')
}

# Difference to change volume with
function send_brightness_notification {
    brightness=$(get_brightness_percentage)

    # Send the notification
    send_notification_message_bar $brightness "Brightness" $msgId
}

if [[ "$1" == "up" ]]; then
    brightnessctl set +$2%
elif [[ "$1" == "down" ]]; then
    brightnessctl set $2%-
else
    echo warning: input not recognized
    echo usage:
    echo -e "\tup, down - increase/decrease brightness"
    echo -e "\tbright - set percieved screen brightness"
    exit
fi

send_brightness_notification
