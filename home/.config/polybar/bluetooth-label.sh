#! /bin/sh
#
# bluetooth.sh
# Copyright (C) 2019 hitsnapper <hitsnapper@Znap>
#
# Distributed under terms of the MIT license.
#

power=`echo $(bluetoothctl show | grep Powered)`
if [ "$power" = "Powered: yes" ]; then
    echo 
else
    echo 
fi



# if pressed, toggle power
# auto-connect to paired?
