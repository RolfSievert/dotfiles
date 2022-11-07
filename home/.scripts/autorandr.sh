#! /bin/sh
#
# settings-menu.sh
#

OPTIONS=($(autorandr --detected))
# add full list if no profiles are detected
if [ ${#OPTIONS[@]} -eq 0 ]; then
    OPTIONS=($(autorandr --list))
fi

ROFI_THEME=(
    -theme-str "window { width: 16%; }"
    -theme-str "listview { lines: ${#OPTIONS[@]}; }"
)

ROFI_OPTIONS=(
    -location 1
    -kb-cancel 'Super_L,Escape'
)

SELECTED_INDEX=0

while true; do
    SELECTION=`printf '%s\n' "${OPTIONS[@]}" | rofi -i "${ROFI_OPTIONS[@]}" "${ROFI_THEME[@]}" -dmenu -p "Menu" -selected-row $SELECTED_INDEX`

    if [ -z $SELECTION ]; then
        exit
    else
        for option_i in "${!OPTIONS[@]}"; do
            if [ "$SELECTION" == "${OPTIONS[$option_i]}" ]; then
                SELECTED_INDEX=$option_i
                autorandr "${OPTIONS[$option_i]}"

                break
            fi
        done
    fi
done
