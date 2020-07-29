#! /bin/sh
#
# bluetooth.sh
# Copyright (C) 2019 hitsnapper <hitsnapper@Znap>
#
# Distributed under terms of the MIT license.
#

power=`echo $(bluetoothctl show | grep Powered)`
info=`echo $(bluetoothctl info | grep Connected)`
icon=`echo $(bluetoothctl info | grep Icon)`
if [ "$power" = "Powered: yes" ]; then
    # If connected to a device
    if [ "$info" = "Connected: yes" ]; then
        if [ "$icon" = "Icon: audio-card" ]; then
            echo 󰂰
            #
        else
            echo 󰂱
        fi
    else
        echo 󰂯
    fi
else
    echo 󰂲
fi



# if pressed, toggle power
# auto-connect to paired?
