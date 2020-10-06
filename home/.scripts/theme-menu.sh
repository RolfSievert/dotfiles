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

# Get time and date

SELECTION="1"
while [ ! -z "$SELECTION" ]; do
    SELECTION=`printf '%s\n' "${OPTIONS[@]}" | rofi -i -width 16 -height 2 -location 1 -kb-cancel 'Super_L,Escape' -lines ${#OPTIONS[@]} -dmenu -p "Theme Menu"`

    if [[ "$SELECTION" == ${OPTIONS[0]} ]]; then
        ~/.scripts/theme-creator.sh > /dev/null
    elif [[ "$SELECTION" == ${OPTIONS[1]} ]]; then
        ~/.scripts/theme-editor.sh >/dev/null
    elif [[ "$SELECTION" == ${OPTIONS[2]} ]]; then
        ~/.scripts/theme-setter.sh >/dev/null
    elif [[ "$SELECTION" == ${OPTIONS[3]} ]]; then
        ~/.scripts/theme-randomizer.sh >/dev/null
    fi
done
