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

# Install Plug for nvim
read -p "Install Plug for neovim?" -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
	    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

: ' Not needed since nvim has link within its init
# Link vimrc to .config/nvim/init.vim
if [ ! -d ~/.config/nvim ]; then
    mkdir ~/.config/nvim;
fi
ln ~/.vimrc ~/.config/nvim/init.vim
'

# Install rmarkdown with R
#R install.packages("rmarkdown")

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
