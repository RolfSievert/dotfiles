#! /bin/sh

# Install general packages
read -p "Install general packages?" -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    PACKAGES=$(cat ~/.scripts/system/install_system/general_packages.txt | grep -v '#')
    yay -S --needed $PACKAGES
fi

# Install i3 packages
read -p "Install i3 packages?" -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    PACKAGES=$(cat ~/.scripts/system/install_system/i3_packages.txt | grep -v '#')
    yay -S --needed $PACKAGES
fi

# install oh my zsh
read -p "Install oh my zsh?" -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Start services
echo Services:
ls ~/.scripts/system/services/
read -p "Start and add services to startup?" -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
	cd
	sudo ~/.scripts/system/enable-services.sh
fi

# Set colorscheme with wal
read -p "Do you wish to set a system colorscheme with pywal (necessary for polybar and rofi to work)? " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
	# Run wal to make rofi and polybar work
	wal --theme ~/.config/wal/colorschemes/dark/gruvbox-dark-soft.json
fi
