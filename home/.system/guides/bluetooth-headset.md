
These packages are to be installed:

> bluez bluez-utils pulseaudio-bluetooth

If given the message *protocol not available* in `bluetoothctl`, try:

```bash
pactl unload-module module-bluetooth-discover
pactl load-module module-bluetooth-discover
```
