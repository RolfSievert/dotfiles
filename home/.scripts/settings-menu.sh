#! /bin/sh
#
# settings-menu.sh
# Copyright (C) 2019 rolfsievert <rolfsievert@manjaro>
#
# Distributed under terms of the MIT license.
#

OPTIONS=(
    "Change Colorscheme" 
    "Test Backgrounds"
    "Set theme"
    "Set random theme"
)

# Get time and date

SELECTION=`printf '%s\n' "${OPTIONS[@]}" | rofi -i -width 16 -height 2 -location 1 -kb-cancel 'Super_L,Escape' -lines ${#OPTIONS[@]} -dmenu -p "Menu"`

if [[ "$SELECTION" == ${OPTIONS[0]} ]]; then
    ~/.scripts/change-colorscheme.sh > /dev/null &
elif [[ "$SELECTION" == ${OPTIONS[1]} ]]; then
    IMG_FOLD=`$HOME/.scripts/select-folder-prompt.sh $HOME`
    # use 2>/dev/null to supress error output
    ~/.scripts/background-tester.sh "$IMG_FOLD" >/dev/null 2>/dev/null &
elif [[ "$SELECTION" == ${OPTIONS[2]} ]]; then
    ~/.scripts/theme-setter.sh >/dev/null &
elif [[ "$SELECTION" == ${OPTIONS[3]} ]]; then
    ~/.scripts/theme-randomizer.sh >/dev/null &
fi
