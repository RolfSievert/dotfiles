#! /bin/sh

# Script usage:
# ./backlight.sh [up/down] [val]

source $(dirname $0)/message_bar.sh

# Arbitrary but unique message id
msgId="991050"

function get_backlight_percentage {
    current=$(brightnessctl get)
    max=$(brightnessctl max)
    float=$((100 * current / max))
    echo ${float%.*}
}

function get_display_name {
    echo $(xrandr | grep -w connected | cut -f '1' -d ' ')
}

# Difference to change volume with
function send_backlight_notification {
    backlight=$(get_backlight_percentage)

    # Send the notification
    send_notification_message_bar $backlight "Brightness ($backlight%)" $msgId
}

if [[ "$1" == "up" ]]; then
    brightnessctl set +$2%
elif [[ "$1" == "down" ]]; then
    brightnessctl set $2%-
else
    echo warning: input not recognized
    echo usage:
    echo -e "\tup, down - increase/decrease backlight brightness"
    exit
fi

send_backlight_notification
