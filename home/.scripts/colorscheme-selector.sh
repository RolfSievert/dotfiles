#! /bin/sh
#
# colorscheme-selector.sh
# Copyright (C) 2019 Rolf Sievert
#
# Distributed under terms of the MIT license.
#

# Use this with rofi to select a color scheme
# Usage: ./colorscheme-selector.sh [*folders]

# Select colorschemes, which upon selection will be applied.
# When script ends, all selected colorscheme paths are returned and current colorscheme is re-applied.

# Folders conatining colorschemes
folders=(
    ~/.config/wal/colorschemes
    ~/.config/wal/colorschemes/dark
    ~/.config/wal/colorschemes/light
    ~/.config/wal/colorschemes/rs-dark
    ~/.config/wal/colorschemes/rs-light
)
# accepted extensions for pywal
extensions=(
    json
)

colorschemes=()
colorschemenames=()

# If given folder root, override folders array
if [ ! -z "$1" ]; then
    folders=("$@")
fi

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

cp ~/.cache/wal/colors.json ~/.cache/wal/colors-old.json
SELECTION=()
SELECTED="0"

while [ -n "$SELECTED" ]; do
    # Build list of available options and their current selection
    OPTIONS=()
    for colscheme in "${colorschemes[@]}"; do
        # if selection conatins colorscheme
        if [[ " ${SELECTION[@]} " =~ " ${colscheme} " ]]; then
            OPTIONS+=("[x] $(basename -- ${colscheme})")
        else
            OPTIONS+=("[ ] $(basename -- ${colscheme})")
        fi
    done

    #SELECTED=$(printf '[ ] %s\n' "${colorschemenames[@]}" | rofi -dmenu -selected-row "${SELECTED}" -mesg "Set coloscheme with wal." -p "Colorschemes")
    SELECTED=$(printf '%s\n' "${OPTIONS[@]}" | rofi -width 20 -dmenu -selected-row "${SELECTED}" -mesg "Select colorschemes to preview." -p "Colorschemes")
    # Check if selected item is checked
    if [ "${SELECTED:1:1}" == "x" ]; then
        CHECKED=true
    else
        CHECKED=false
    fi

    SELECTED="${SELECTED:4}"


    # If given a file as input, change colorscheme with wal
    if ! [[ -z "$SELECTED" ]]; then
        # loop through colorschemes
        for file in ${colorschemes[@]}; do
            # check if filename matches with input
            filename=$(basename -- "$file")
            if [ "$SELECTED" == "$filename" ]; then
                # apply colorscheme and break loop

                # if checked, remove from selection, else add to selection
                if [ "$CHECKED" == true ]; then
                    wal --theme ~/.cache/wal/colors-old.json > /dev/null
                    SELECTION=( "${SELECTION[@]/$file}" )
                else
                    SELECTION+=("$file")
                    wal --theme $file > /dev/null
                fi

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
wal --theme ~/.cache/wal/colors-old.json > /dev/null
rm ~/.cache/wal/colors-old.json

echo "${SELECTION[@]}"
