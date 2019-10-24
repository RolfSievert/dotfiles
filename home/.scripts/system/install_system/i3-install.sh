#! /bin/sh

# Install general packages
PACKAGES = $(cat ~/.scripts/system/install_system/general_packages.txt | grep -v '#')
yay -S --needed $PACKAGES

# (Install i3)

# Install i3 packages
PACKAGES = $(cat ~/.scripts/system/install_system/i3_packages.txt | grep -v '#')
yay -S --needed $PACKAGES

# Run wal

# Check for an ssh key, else generate and open github afterwards and wait for user input
read -p "Do you want to crete a ssh key? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # do dangerous stuff
fi

# Check if castle dotfiles is initiated, else clone and link

# Install oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Build nvim with python for YCM support
pip3 install --user neovim

# Install Plug for nvim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Link vimrc to .config/nvim/init.vim
if [ ! -d ~/.config/nvim ]; then
    mkdir ~/.config/nvim;
fi
ln ~/.vimrc ~/.config/nvim/init.vim

# Install YouCompleteMe
cd ~/.vim/plugged/YouCompleteMe/
sudo python3 ./install.py

# Install rmarkdown with R
R install.packages("rmarkdown")

# Start services
cd
sudo ~/.scripts/system/enable-services.sh

# Set colorscheme with wal
read -p "Do you wish to set a colorscheme from wal folder? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # do dangerous stuff
fi


# Spotify fix for i3
iptables -N TCP
iptables -N UDP
iptables -A TCP -p tcp --dport 57621 -j ACCEPT -m comment --comment spotify
iptables -A UDP -p udp --dport 57621 -j ACCEPT -m comment --comment spotify
iptables-save -f /etc/iptables/iptables.rules
