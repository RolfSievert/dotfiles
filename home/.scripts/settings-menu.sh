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
)

SELECTION=`printf '%s\n' "${OPTIONS[@]}" | rofi -i -width 30 -height 2 -location 2 -lines ${#OPTIONS[@]} -dmenu -p "Menu"`

if [[ "$SELECTION" == ${OPTIONS[0]} ]]; then
    ~/.scripts/change-colorscheme.sh > /dev/null &
elif [[ "$SELECTION" == ${OPTIONS[1]} ]]; then
    IMG_FOLD=`$HOME/.scripts/select-folder-prompt.sh $HOME`
    # use 2>/dev/null to supress error output
    ~/.scripts/background-tester.sh "$IMG_FOLD" >/dev/null 2>/dev/null &
fi
