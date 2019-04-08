#! /bin/sh
GENPACKPATH='general_packages.txt'
GENPACK=$(grep "^[^#]" $GENPACKPATH)
I3PACKPATH='general_packages.txt'
I3PACK=$(grep "^[^#]" $I3PACKPATH)

# Check if pakku is installed

# Install general packages
pakku -S $GENPACK

# Ask if i3 packages should be installed

# Check if castle dotfiles is initiated

