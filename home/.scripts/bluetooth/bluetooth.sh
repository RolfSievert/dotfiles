#! /bin/sh
#
# bluetooth.sh
# Copyright (C) 2019 hitsnapper <hitsnapper@Znap>
#
# Distributed under terms of the MIT license.

# This script is made for use with rofi.
# (in progress)

# paired-devices to list paired
# devices to list available devices

# LAYOUT

# Power
# Pair new - scan on/off
# List paired sorted on availabe

powered=`echo $(bluetoothctl show | grep Powered:)`
paired=()
tmp=()
tmp=(`echo $(bluetoothctl paired-devices)`)
tmp=("${tmp[@]:1}")
counter=0
for str in "${tmp[@]}"; do
    if [ "$str" == "Device" ]; then
        counter+=1
    else
        paired[$counter]+=" $str"
    fi
done

# Auto connect?
# Echo paired visible devices


# if no input, show default options and paired devices
if [[ $# -eq 0 ]] ; then
    echo $powered
    echo "Pair new device"
    printf '%s\n' "${paired[@]}"

# Toggle power
elif [ "$1" == "Powered: no" ]; then
    bluetoothctl power on >/dev/null
    # show default options and paired devices
    echo "Powered: yes"
    echo "Pair new device"
    printf '%s\n' "${paired[@]}"
elif [ "$1" == "Powered: yes" ]; then
    bluetoothctl power off >/dev/null
    # show default options and paired devices
    echo "Powered: no"
    echo "Pair new device"
    printf '%s\n' "${paired[@]}"

# Pair device
elif [ "$1" == "Pair new device" ]; then
    bluetoothctl scan on
    # Wait a sec
    # list visible devices

# If input is paired device, attempt to connect
else
    for dev in ${paired[@]}; do
        if [[ "$1" in "$dev" ]]; then
            bluetoothctl connect $1 >/dev/null
        fi
    done
fi
