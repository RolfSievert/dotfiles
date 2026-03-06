#!/usr/bin/env bash
#
# bluetooth.sh
# Prints an icon depending on the state of the bluetooth adapter.
#

result="󰂲"

devices=$(busctl tree org.bluez | grep -oP '/org/bluez/hci\d+/dev_[^/]+(?=\s|$)')
is_connected() {
    local dev="$1"
    busctl get-property org.bluez "$dev" org.bluez.Device1 Connected | grep -q true
}

device_type() {
    local dev="$1"
    busctl get-property org.bluez "$dev" org.bluez.Device1 Icon | awk -F\" '{print $2}'
}

device_types=()

for dev in $devices; do
    if is_connected "$dev"; then
        device_types+=("$(device_type "$dev")")
    fi
done

is_adapter_powered() {
    busctl get-property org.bluez /org/bluez/hci0 org.bluez.Adapter1 Powered | grep -q true
}

if is_adapter_powered; then
    result="󰂯" 

    for device_type in "${device_types[@]}"; do
        if [[ "$device_type" == "audio-card" ]]; then
            result+="󰓃"
        elif [[ "$device_type" == "audio-headphones" ]]; then
            result+="󰋋"
        elif [[ "$device_type" == "audio-headset" ]]; then
            result+="󰋎"
        elif [[ "$device_type" == "input-gaming" ]]; then
            result+="󰮂"
        elif [[ "$device_type" == "input-keyboard" ]]; then
            result+="󰌌"
        elif [[ "$device_type" == "input-mouse" ]]; then
            result+="󰍽"
        elif [[ "$device_type" == "input-tablet" ]]; then
            result+="󰓶"
        elif [[ "$device_type" == "input-joystick" ]]; then
            result+="󱎓"
        else
            result+="?"
        fi
    done
fi

echo "$result"
