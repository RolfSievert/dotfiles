#! /bin/sh
#
# change-colorscheme.sh
#

# Use this with rofi to select a color scheme
# Usage: ./change-colorscheme.sh [*folders]

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

ROFI_THEME=(
    -theme-str "window { width: 20%; }"
)

ROFI=(
    rofi
    -dmenu
    -location 0
    -kb-cancel 'Escape'
    -mesg "Set colorscheme with wal."
    -p "Colorscheme"
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

SELECTED="0"

while [ -n "$SELECTED" ]; do
    SELECTED=$(printf '%s\n' "${colorschemenames[@]}" | "${ROFI[@]}" "${ROFI_THEME[@]}" -selected-row "${SELECTED}")
    echo "$SELECTED"

    # If given a file as input, change colorscheme with wal
    if ! [[ -z "$SELECTED" ]]; then
        # loop through colorschemes
        for file in ${colorschemes[@]}; do
            # check if filename matches with input
            filename=$(basename -- "$file")
            if [ "$SELECTED" == "$filename" ]; then
                # apply colorscheme and break loop
                wal --theme $file > /dev/null
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
