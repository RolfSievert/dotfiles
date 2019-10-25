#! /bin/sh
#
# colorscheme-selector.sh
# Copyright (C) 2019 hitsnapper <hitsnapper@Znap>
#
# Distributed under terms of the MIT license.
#

# Use this with rofi to select a color scheme

# Folders conatining colorschemes
folders=(
    ~/.config/wal/colorschemes
    ~/.config/wal/colorschemes/dark
    ~/.config/wal/colorschemes/light
)
# accepted extensions for pywal
extensions=(
    json
)

colorschemes=()
colorschemenames=()

# Loop through folders containing colorschemes
for folder in ${folders[@]}; do
    # Loop through items in folder
    for file in $folder/*; do
        # make sure path is not directory
        if [ ! -d "$file" ]; then
            # extract file extension
            filename=$(basename -- "$file")
            ext="${filename##*.}"
            # Check if file extension is acceptable for pywal
            if [[ " ${extensions[@]} " =~ " ${ext} " ]]; then
                #echo $filename
                colorschemenames+=($filename)
                colorschemes+=($file)
            fi
        fi
    done
done

SELECTED="0"

while [ -n "$SELECTED" ]; do
    SELECTED=$(printf '%s\n' "${colorschemenames[@]}" | rofi -dmenu -selected-row "${SELECTED}" -mesg "Set coloscheme with wal." -p "Colorschemes")
    echo "$SELECTED"

    # If given a file as input, change colorscheme with wal
    if ! [[ -z "$SELECTED" ]]; then
        # loop through colorschemes
        for file in ${colorschemes[@]}; do
            # check if filename matches with input
            filename=$(basename -- "$file")
            if [ "$SELECTED" == "$filename" ]; then
                # apply colorscheme and break loop
                wal -f $file > /dev/null
                break
            fi
        done
    fi

    # Get row number
    for i in "${!colorschemenames[@]}"; do
       if [[ "${colorschemenames[$i]}" = "${SELECTED}" ]]; then
           SELECTED="${i}"
           break;
       fi
    done
done
