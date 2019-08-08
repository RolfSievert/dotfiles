# Scripts

## Colorscheme changer
This script (change-colorscheme.sh) uses Rofi and Pywal. 
Edit the script *colorscheme/colorscheme-selector.sh* to select where local colorschemes are found and which file extensions to be supported. 
There are two arrays defining these options in the script.

## System scripts
Scripts located in *system/*.

### Cleaning the system
*clean_system.ch* does what it says, gives some cleaning options.

### User services
*enable-services.sh* copies all services from the *services/* folder to *~/.config/systemd/user*.
This is where it is recommended to put user services on arch wiki.
These services are thereafter enabled and started.

### System health check
*health-check.sh* attempts to (obviously) check the health of the system.
