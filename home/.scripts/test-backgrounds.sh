#! /bin/sh
#
# test-backgrounds.sh
#

# Moves to next empty workspace and opens floating window previewing images.
# Clicking '0' applies the image as background.

if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
    echo "Script requires at least one path"
    exit
fi

# Arguments of paths passed to script
PATHS="$@"

# Open next empty workspace
python ~/.config/i3/next_empty.py

scale=40
width=$((16 * scale))
height=$((9 * $scale))
feh --title "float" --geometry "$width"x"$height" --scale-down --zoom fill --action "feh --bg-fill %F" $PATHS