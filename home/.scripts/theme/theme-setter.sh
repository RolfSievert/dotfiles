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

ROFI_THEME=(
    -theme-str "window { width: 16%; }"
    -theme-str "listview { columns: 2; }"
)

ROFI_OPTIONS=(
    -p "Theme" # query title
    -location 0
    -i # case insensitive search
    #-kb-cancel 'Super_L,Escape'
)

SELECTED_INDEX="0"

while true; do
    # run rofi and select between themes
    SELECTION=$(printf '%s\n' "${THEME_NAMES[@]}" | rofi "${ROFI_OPTIONS[@]}" "${ROFI_THEME[@]}" -dmenu -selected-row $SELECTED_INDEX)
    theme_folder=""

    if [ -z "$SELECTION" ]; then
        # Return if none is selected
        exit
    else
        # If given a valid folder as input, set background

        # Find folder with matching basename
        for fold_i in "${!THEMES[@]}"; do
            # check if basename matches with theme name
            foldname=$(basename -- "${THEMES[fold_i]}")
            if [ "$SELECTION" == "$foldname" ]; then
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
    ~/.scripts/colorscheme/change-colorscheme.sh $theme_folder

done
