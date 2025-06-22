#! /bin/sh

# Script usage:
# ./screen_gamma.sh [up/down] [val]

source $(dirname $0)/message_bar.sh

# Arbitrary but unique message id
msgId="991051"

function get_gamma_percentage {
    gamma=$(xrandr --verbose | grep -i brightness | cut -f '2' -d ' ')
    gamma_percentage=$(bc <<< "$gamma * 100")
    echo ${gamma_percentage%.*}
}

function get_display_name {
    echo $(xrandr | grep -w connected | cut -f '1' -d ' ')
}

# Difference to change volume with
function send_notification {
    gamma=$(get_gamma_percentage)
    bar_value=$(bc <<< "$gamma - 100")
    echo "$gamma"

    # Send the notification
    send_notification_message_bar $bar_value "Gamma ($gamma%)" $msgId
}

if [[ "$1" == "up" ]]; then
    gamma=$(get_gamma_percentage)
    new_gamma=$(bc <<< "$gamma + $2")

    if [ $new_gamma -gt "200" ]; then
        new_gamma="200"
    fi

    normalized=$(bc <<< "scale=2; $new_gamma / 100")

    xrandr --output $(get_display_name) --brightness "$normalized"
elif [[ "$1" == "down" ]]; then
    gamma=$(get_gamma_percentage)
    new_gamma=$(bc <<< "$gamma - $2")

    if [ $new_gamma -lt "100" ]; then
        new_gamma="100"
    fi

    normalized=$(bc <<< "scale=2; $new_gamma / 100")

    xrandr --output $(get_display_name) --brightness "$normalized"
else
    echo warning: input not recognized
    echo usage:
    echo -e "\tup, down - increase/decrease screen gamma"
    exit
fi

send_notification
