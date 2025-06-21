#! /bin/sh

# Script usage:
# ./contrast.sh [up/down] [val]

source $(dirname $0)/message_bar.sh

# Arbitrary but unique message id
msgId="991051"

function get_contrast_percentage {
    contrast=$(xrandr --verbose | grep -i brightness | cut -f '2' -d ' ')
    contrast_percentage=$(bc <<< "$contrast * 100")
    echo ${contrast_percentage%.*}
}

function get_display_name {
    echo $(xrandr | grep -w connected | cut -f '1' -d ' ')
}

# Difference to change volume with
function send_notification {
    contrast=$(get_contrast_percentage)
    bar_value=$(bc <<< "$contrast - 100")
    echo "$contrast"

    # Send the notification
    send_notification_message_bar $bar_value "Contrast ($contrast)" $msgId
}

if [[ "$1" == "up" ]]; then
    contrast=$(get_contrast_percentage)
    new_contrast=$(bc <<< "$contrast + $2")

    if [ $new_contrast -gt "200" ]; then
        new_contrast="200"
    fi

    normalized=$(bc <<< "scale=2; $new_contrast / 100")

    xrandr --output $(get_display_name) --brightness "$normalized"
elif [[ "$1" == "down" ]]; then
    contrast=$(get_contrast_percentage)
    new_contrast=$(bc <<< "$contrast - $2")

    if [ $new_contrast -lt "100" ]; then
        new_contrast="100"
    fi

    normalized=$(bc <<< "scale=2; $new_contrast / 100")

    xrandr --output $(get_display_name) --brightness "$normalized"
else
    echo warning: input not recognized
    echo usage:
    echo -e "\tup, down - increase/decrease screen contrast"
    exit
fi

send_notification
