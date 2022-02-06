#! /bin/sh
#
# theme-editor.sh
# Copyright (C) 2020 Rolf Sievert
#
# Distributed under terms of the MIT license.
#

# Edit Theme
#   - Select Theme
#   - Add colorscheme(s)
#       * test & add colorscheme(s)
#   - Remove colorscheme
#       * test & remove colorscheme
#   - Remove theme

ROFI_THEME=(
    -theme-str "window { width: 20%; }"
)

ROFI=(
    rofi
    -dmenu
    -location 0
    -kb-cancel 'Escape'
)

ROOT_FOLDER=$(dirname $0)/../
COLORSCHEME_SELECTOR_SCRIPT=$ROOT_FOLDER/colorscheme/colorscheme-selector.sh

THEMES_FOLDER="$HOME/Media/Themes/"
THEMES=()
function updateThemes() {
    cd "$THEMES_FOLDER"
    THEMES=($(ls -d -- */))
    cd -
}

updateThemes

OPTIONS=(
    "Add colorschemes" 
    "Remove colorschemes"
    "Apply background"
    "Remove theme"
)

SELECTED_THEME="0"

# loop over themes until escaped
while true; do
    SELECTED_THEME=$(printf '%s\n' "${THEMES[@]}" | "${ROFI[@]}" "${ROFI_THEME[@]}" -selected-row "${SELECTED_THEME}" -p "Theme" -mesg "Select theme to edit.")

    if [ -z "$SELECTED_THEME" ]; then
        exit
    fi

    SELECTION="0"
    # loop over theme options until escaped
    while [ -n "$SELECTION" ]; do
        SELECTION=$(printf '%s\n' "${OPTIONS[@]}" | "${ROFI[@]}" "${ROFI_THEME[@]}" -lines ${#OPTIONS[@]} -p "Theme Menu")

        THEME_PATH="${THEMES_FOLDER}${SELECTED_THEME}"
        if [[ "$SELECTION" == ${OPTIONS[0]} ]]; then
            # add colorschemes
            COLORSCHEMES=($($COLORSCHEME_SELECTOR_SCRIPT))
            for c in "${COLORSCHEMES[@]}"; do
                cp "$c" "$THEME_PATH"
            done
        elif [[ "$SELECTION" == ${OPTIONS[1]} ]]; then
            # remove colorschemes
            COLORSCHEMES=($($COLORSCHEME_SELECTOR_SCRIPT "$THEME_PATH"))
            for c in $COLORSCHEMES; do
                rm "$c"
            done
        elif [[ "$SELECTION" == ${OPTIONS[2]} ]]; then
                images=($THEME_PATH/{*.jpg,*.png})
                # set first image as background
                ~/.scripts/background-setter.sh "$images"
        elif [[ "$SELECTION" == ${OPTIONS[3]} ]]; then
            PROMPT=$(printf "no\nyes" | rofi -dmenu -p "DELETE THEME '$THEME_PATH'" -mesg "Are you sure you want to remove this theme? No undos!")
            if [[ "$PROMPT" == "yes" ]]; then
                # remove theme
                rm -rf "$THEME_PATH"
                echo "Theme '$SELECTED_THEME' deleted."

                # update themes list
                updateThemes

                # exit theme options loop
                break
            fi
        fi
    done


    # Get row number
    for i in "${!THEMES[@]}"; do
       if [[ "${THEMES[$i]}" = "${SELECTED_THEME}" ]]; then
           SELECTED_THEME="${i}"
           break;
       fi
    done
done
