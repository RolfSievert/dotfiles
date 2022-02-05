#! /bin/sh
#
# bt-autoconnect-paired.sh
# Autoconnect to paired bluetooth devices

POWER=`bluetoothctl show | grep Powered | awk '{print $2}'`

if [ "$POWER" == "yes" ]; then
    bluetoothctl disconnect
    bluetoothctl power off
    exit
else
    bluetoothctl power on
fi

DEVS=`bluetoothctl paired-devices | awk '{print $2}'`
echo ${DEVS[@]}
for dev in "${DEVS[@]}"; do
    bluetoothctl connect $dev
done
