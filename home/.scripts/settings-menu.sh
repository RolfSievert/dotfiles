#! /bin/sh
#
# settings-menu.sh
#

ROOT_FOLDER=$(dirname "$0")
CHANGE_COLORSCHEME_SCRIPT=($ROOT_FOLDER/colorscheme/change-colorscheme.sh)
BACKGROUND_TESTER_SCRIPT=($ROOT_FOLDER/background-tester.sh)
THEME_SETTER_SCRIPT=($ROOT_FOLDER/theme/theme-setter.sh)
THEME_RANDOMIZER_SCRIPT=($ROOT_FOLDER/theme/theme-randomizer.sh)
SELECT_FOLDER_SCRIPT=($ROOT_FOLDER/select-folder-prompt.sh)
EDIT_COLORSCHEME_SCRIPT=($ROOT_FOLDER/colorscheme/edit-colorscheme.sh)
AUTORANDR=($ROOT_FOLDER/autorandr.sh)

OPTIONS=(
    "Change Colorscheme"
    "Test Backgrounds"
    "Set theme"
    "Set random theme"
    "Edit Colorscheme"
    "Set autorandr profile"
)

ROFI_THEME=(
    -theme-str "window { width: 16%; }"
    -theme-str "listview { lines: ${#OPTIONS[@]}; }"
)

ROFI_OPTIONS=(
    -location 1
    -kb-cancel 'Super_L,Escape'
)

SELECTION=`printf '%s\n' "${OPTIONS[@]}" | rofi -i "${ROFI_OPTIONS[@]}" "${ROFI_THEME[@]}" -dmenu -p "Menu"`

if [[ "$SELECTION" == ${OPTIONS[0]} ]]; then
    $CHANGE_COLORSCHEME_SCRIPT > /dev/null &
elif [[ "$SELECTION" == ${OPTIONS[1]} ]]; then
    IMG_FOLD=$($SELECT_FOLDER_SCRIPT $HOME)
    # use 2>/dev/null to supress error output
    $BACKGROUND_TESTER_SCRIPT "$IMG_FOLD" >/dev/null 2>/dev/null &
elif [[ "$SELECTION" == ${OPTIONS[2]} ]]; then
    $THEME_SETTER_SCRIPT >/dev/null &
elif [[ "$SELECTION" == ${OPTIONS[3]} ]]; then
    $THEME_RANDOMIZER_SCRIPT >/dev/null &
elif [[ "$SELECTION" == ${OPTIONS[4]} ]]; then
    $EDIT_COLORSCHEME_SCRIPT >/dev/null &
elif [[ "$SELECTION" == ${OPTIONS[5]} ]]; then
    $AUTORANDR >/dev/null &
fi
