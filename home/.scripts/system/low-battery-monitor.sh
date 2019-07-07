#! /bin/sh

# This script checks if battery is below specific amount and sends notification in that case

BATTINFO=`acpi -b`
if [[ `echo $BATTINFO | grep Discharging` && `echo $BATTINFO | cut -f 5 -d " "` < 00:30:00 ]] ; then
    DISPLAY=:0.0 /usr/bin/notify-send "low battery" "$BATTINFO" --icon=battery
fi
