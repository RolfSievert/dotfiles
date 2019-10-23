#! /bin/sh
#
# test-backgrounds.sh
#

# Moves to next empty workspace and opens floating window previewing images.
# Clicking '0' applies the image as background.

REMOVE_ACTION=3
MOVE_ACTION=1

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
height=$((9 * scale))

# Call feh (use title "float" for i3 to set window to floating. see i3 config)
feh --title "float" --geometry "$width"x"$height" --scale-down --auto-zoom --action ";~/.scripts/background-setter.sh %F" --action$MOVE_ACTION "mv %F ~/Media/Backgrounds/" --action$REMOVE_ACTION "~/.scripts/remove-prompt.sh %F" $PATHS
