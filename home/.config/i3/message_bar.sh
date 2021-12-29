# Shows a notification with a progress bar
function send_notification_message_bar {
    value="$1"
    title="$2"
    # bind this notification to a specific ID so that a new instance is not created every call
    msgId="$3"
    # Calculate number of dashes and spaces
    barsize=5
    dashes=$(($value / $barsize))
    spaces=$(((100 / $barsize) - $dashes))
    # Make the bar with special character ─ (not dash -)
    # NOTE: this creates at least one character
    bar1=$(printf "█"'%.s' $(eval "echo {0.."$(($dashes))"}"))
    # Create spaces to make notification size constant
    bar2=$(printf " "'%.s' $(eval "echo {0.."$(($spaces))"}"))

    echo \"$bar2\"

    # Center the title
    title_indent_count=$((((100 / $barsize) - ${#title}) / 2))
    title_indent=$(printf " "'%.s' $(eval "echo {0.."$(($title_indent_count))"}"))

    # Send the notification, -r is int reference value
    dunstify --appname=custom-bar -u normal --icon=0 -r "$msgId" "$title" "${bar2:1}$bar1"
}
