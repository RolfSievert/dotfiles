#! /bin/sh
#
# theme-setter.sh
# Copyright (C) 2019 rolfsievert <rolfsievert@manjaro>
#
# Distributed under terms of the MIT license.
#

THEMES_PATH=~/Media/Themes
# Get list of folders in themes folder
THEMES=($THEMES_PATH/*)
THEME_NAMES=()

# Seed random generator
#RANDOM=$$$(date +%s)

# Loop through items in folder
for theme in ${THEMES[@]}; do
    # make sure path is a directory
    if [ -d "$theme" ]; then
        # extract theme name from folder path
        THEME_NAMES+=($(basename -- "$theme"))
    fi
done

# Get random theme
THEME=${THEMES[$RANDOM % ${#THEMES[@]} ]}
# Get image
images=($THEME/{*.jpg,*.png})
# Set bg as a way of previewing before having to set alignment
feh --bg-max "$images"
# set first image as background
~/.scripts/background-setter.sh "$images"
# select random colorscheme
colorschemes=($THEME/*.json)
colorscheme=${colorschemes[$RANDOM % ${#colorschemes[@]} ]}
# Set colorscheme with wal
echo $colorscheme
wal -n -f "$colorscheme"
