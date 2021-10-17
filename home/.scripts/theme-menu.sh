#! /bin/sh
#
# theme-setter.sh
#

# Script functionality
#
# Create Theme
#   - select image
#   - test & select colorscheme(s)
#   - name theme
#   - create theme folder under ~/Media/Themes/
#   - symlink selected colorschemes to theme folder
#
# Edit Theme
#   - Select Theme
#   - Add colorscheme(s)
#       * test & add colorscheme(s)
#   - Remove colorscheme
#       * test & remove colorscheme
#   - Remove theme
#
# Set Theme

OPTIONS=(
    "Create Theme" 
    "Edit Theme"
    "Set Theme"
    "Set random theme"
)

ROFI_THEME=(
    -theme-str "window { width: 16%; }"
    -theme-str "listview { lines: ${#OPTIONS[@]}; }"
)

ROFI_OPTIONS=(
    -location 1
    -kb-cancel 'Super_L,Escape'
)

THEME_SCRIPTS_DIR=$(dirname $0)/theme/

SELECTION="1"
while [ ! -z "$SELECTION" ]; do
    SELECTION=`printf '%s\n' "${OPTIONS[@]}" | rofi -i "${ROFI_OPTIONS[@]}" "${ROFI_THEME[@]}" -dmenu -p 'Theme Menu'`

    if [[ "$SELECTION" == ${OPTIONS[0]} ]]; then
        $THEME_SCRIPTS_DIR/theme-creator.sh > /dev/null
    elif [[ "$SELECTION" == ${OPTIONS[1]} ]]; then
        $THEME_SCRIPTS_DIR/theme-editor.sh >/dev/null
    elif [[ "$SELECTION" == ${OPTIONS[2]} ]]; then
        $THEME_SCRIPTS_DIR/theme-setter.sh >/dev/null
    elif [[ "$SELECTION" == ${OPTIONS[3]} ]]; then
        $THEME_SCRIPTS_DIR/theme-randomizer.sh >/dev/null
    fi
done
