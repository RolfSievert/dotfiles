#! /bin/sh
#
# colorscheme-selector.sh
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

ROFI_THEME=(
    -theme-str "window { width: 20%; }"
)

ROFI=(
    rofi
    -dmenu
    -location 0
    -kb-cancel 'Escape'
    -mesg "Select and preview colorschemes."
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

cp ~/.cache/wal/colors.json ~/.cache/wal/colors-old.json
SELECTED="0"

SCRIPT_FOLDER=$(dirname "$(realpath $0)")

ENTR_PID=".entr_pid.txt"
PREVIEW_PID=".preview_colorscheme_pid.txt"

while [ -n "$SELECTED" ]; do
    # Build list of available options and their current selection
    OPTIONS=()
    for colscheme in "${colorschemes[@]}"; do
        OPTIONS+=("$(basename -- ${colscheme})")
    done

    #SELECTED=$(printf '[ ] %s\n' "${colorschemenames[@]}" | rofi -dmenu -selected-row "${SELECTED}" -mesg "Set coloscheme with wal." -p "Colorschemes")
    SELECTED=$(printf '%s\n' "${OPTIONS[@]}" | "${ROFI[@]}" "${ROFI_THEME[@]}" -selected-row "${SELECTED}")
    # Check if selected item is checked

    # If given a file as input, change colorscheme with wal
    if ! [[ -z "$SELECTED" ]]; then
        # loop through colorschemes
        for file in ${colorschemes[@]}; do
            # check if filename matches with input
            filename=$(basename -- "$file")
            if [ "$SELECTED" == "$filename" ]; then
                wal --theme $file > /dev/null

                # TODO get pid and terminate after closing editor?
                ls $file | entr -n wal --theme $file > /dev/null & echo "$!" > "$SCRIPT_FOLDER"/"$ENTR_PID"
                "$SCRIPT_FOLDER"/preview-colorscheme.py "$SCRIPT_FOLDER/$PREVIEW_PID" &
                sleep 1
                alacritty --class float --working-directory "$(dirname "$file")" -e /usr/bin/zsh -ic "nvim $(basename -- "$file")"

                # restore colorscheme and close preview
                preview_pid=$(cat "$SCRIPT_FOLDER/$PREVIEW_PID")
                kill $preview_pid
                rm "$SCRIPT_FOLDER/$PREVIEW_PID"
                entr_pid=$(cat "$SCRIPT_FOLDER/$ENTR_PID")
                kill $entr_pid
                rm "$SCRIPT_FOLDER/$ENTR_PID"
                wal --theme ~/.cache/wal/colors-old.json > /dev/null

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
rm ~/.cache/wal/colors-old.json

echo "${SELECTION[@]}"
