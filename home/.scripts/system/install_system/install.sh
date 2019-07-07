#! /bin/sh
GENPACKPATH='general_packages.txt'
GENPACK=$(grep "^[^#]" $GENPACKPATH)

# Check if pakku is installed, install elsewise

# Install general packages
pakku -S $GENPACK

# Check if castle dotfiles is initiated

