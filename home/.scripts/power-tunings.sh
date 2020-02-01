#! /bin/sh
#
# power-tunings.sh
# Copyright (C) 2020 rolfsievert <rolfsievert@manjaro>
#
# Distributed under terms of the MIT license.
#

echo 'enabled' | sudo tee -a '/sys/class/net/wlo1/device/power/wakeup';
echo 'enabled' | sudo tee -a '/sys/bus/usb/devices/usb1/power/wakeup';
echo 'enabled' | sudo tee -a '/sys/bus/usb/devices/1-10/power/wakeup';
echo 'enabled' | sudo tee -a '/sys/bus/usb/devices/usb2/power/wakeup';
echo '1500' | sudo tee -a '/proc/sys/vm/dirty_writeback_centisecs'; 
