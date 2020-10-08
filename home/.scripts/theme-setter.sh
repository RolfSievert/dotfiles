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

# Loop through items in folder
for theme in ${THEMES[@]}; do
    # make sure path is a directory
    if [ -d "$theme" ]; then
        # extract theme name from folder path
        THEME_NAMES+=($(basename -- "$theme"))
    fi
done

SELECTED_INDEX="0"

while true; do
    # run rofi and select between themes
    BG=`printf '%s\n' "${THEME_NAMES[@]}" | rofi -width 20 -dmenu -selected-row $SELECTED_INDEX -p "Theme"`
    theme_folder=""

    if [ -z "$BG" ]; then
        # Return if none is selected
        exit
    else
        # If given a valid folder as input, set background

        # Find folder with matching basename
        for fold_i in ${!THEMES[@]}; do
            # check if basename matches with theme name
            foldname=$(basename -- "${THEMES[fold_i]}")
            if [ "$BG" == "$foldname" ]; then
                SELECTED_INDEX="$fold_i"
                # save folder path
                theme_folder=${THEMES[fold_i]}
                # Find images in folder
                images=($theme_folder/{*.jpg,*.png})
                # set first image as background
                ~/.scripts/background-setter.sh "$images"
                break
            fi
        done
    fi

    # run rofi and select colorscheme
    ~/.scripts/change-colorscheme.sh $theme_folder

done
