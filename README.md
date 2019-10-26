# Scripts
Located in *~/.scripts/*

**Main Scripts**
* *theme-setter.sh* - Lists folders in ~/Media/Themes/ with rofi. Selection of theme sets background with feh, then optional colorschemes located in the folder may be applied with pywal.
* *theme-randomizer.sh* - Sets a random image as background and random colorscheme in that theme folder. 
* *change-colorscheme.sh* - Displays local colorschemes (locations pointed out in script)
* *background-tester.sh* - Select a folder containing images with rofi. Press '0' to apply as background, '1' to move image to other folder, '2' to generate colorscheme with pywal, '3' to remove image.
* *background-setter.sh* - Sets a background with feh. Gives option to chose alignment if aspect ratio differs from monitor.
* *settings-menu.sh* - Runs some of these scripts from one rofi-window (i.e. *theme-randomizer.sh*, *change-colorscheme.sh*, ...)

## Colorscheme changer
This script (change-colorscheme.sh) uses Rofi and Pywal. 
Edit the script *change-colorscheme.sh* to select where local colorschemes are found and which file extensions to be supported. 

## System scripts
Scripts located in *system/*.
Used for installation, cleaning, maintenance, etc.

### Cleaning the system
*clean_system.ch* does what it says, gives some cleaning options.

### User services
*enable-services.sh* copies all services from the *services/* folder to *~/.config/systemd/user*.
This is where it is recommended to put user services on arch wiki.
These services are thereafter enabled and started.

### System health check
*health-check.sh* attempts to (obviously) check the health of the system.

# Other
Wallpaper: Photo by Roberto Shumski from Pexels
![Photo by Roberto Shumski from Pexels](https://images.pexels.com/photos/1903702/pexels-photo-1903702.jpeg?cs=srgb&dl=blur-breathtaking-clouds-1903702.jpg&fm=jpg)
