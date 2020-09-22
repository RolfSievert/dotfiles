#! /bin/sh

# Install general packages
#PACKAGES = $(cat ~/.scripts/system/install_system/general_packages.txt | grep -v '#')
#sudo pacman -S --needed $PACKAGES

# Install i3 packages
PACKAGES=$(cat ~/.scripts/system/install_system/i3_packages.txt | grep -v '#')
yay -S --needed $PACKAGES

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

# Link vimrc to .config/nvim/init.vim
if [ ! -d ~/.config/nvim ]; then
    mkdir ~/.config/nvim;
fi
ln ~/.vimrc ~/.config/nvim/init.vim

# Install YouCompleteMe
read -p "Run YouCompleteMe installer?" -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
	cd ~/.vim/plugged/YouCompleteMe/
	sudo python3 ./install.py --clangd-completer --ts-completer
fi

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


# Spotify fix for i3
#iptables -N TCP
#iptables -N UDP
#iptables -A TCP -p tcp --dport 57621 -j ACCEPT -m comment --comment spotify
#iptables -A UDP -p udp --dport 57621 -j ACCEPT -m comment --comment spotify
#iptables-save -f /etc/iptables/iptables.rules
