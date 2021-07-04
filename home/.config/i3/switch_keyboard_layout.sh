#! /bin/sh

if [ $# -eq 0 ]; then
    # No arguments supplied
    OPTIONS=(
        "se" 
        "us"
    )
else
    OPTIONS=( "$@" )
fi


# -o is print only the match and not the search
# -P perl regexp
# CURRENT_LAYOUT=$(localectl | grep -oP "(?<=VC Keymap: ).*")

CURRENT_LAYOUT=$(setxkbmap -query | grep layout | tr -s ' ' | cut -d ' ' -f2)

for i in "${!OPTIONS[@]}"; do
   if [[ "${OPTIONS[$i]}" = "${CURRENT_LAYOUT}" ]]; then
       # remove active keyboard layout
       unset OPTIONS[$i]
   fi
done

echo $OPTIONS

SELECTION=`printf '%s\n' "${OPTIONS[@]}" | rofi -i -width 16 -height 2 -location 3 -kb-cancel 'Super_L,Escape' -lines ${#OPTIONS[@]} -dmenu -p "Keyboard layout: $CURRENT_LAYOUT"`

setxkbmap $SELECTION

# Maybe need to call this to make work in session?
# sudo localectl set-x11-keymap $SELECTION
# sudo localectl set-keymap $SELECTION
