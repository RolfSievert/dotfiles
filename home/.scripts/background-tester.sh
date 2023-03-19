#! /bin/sh
#
# test-backgrounds.sh
#

# Moves to next empty workspace and opens floating window previewing images.
# Clicking '0' applies the image as background.

# Requires scripts select-folder-prompt.sh, background-setter.sh, remove-prompt.sh, wal.sh

MOVE_ACTION=1
PYWAL=2
REMOVE_ACTION=3
COLOR_ANALYSIS=5

if [[ $# -eq 0 ]]; then
    echo "No arguments supplied"
    echo "Script requires at least one path"
    exit 1
fi

# Arguments of paths passed to script
PATHS="$@"

# Open next empty workspace
#python ~/.config/i3/next_empty.py

monitor_resolution="$(xrandr | grep 'connected primary' | grep -Po '\d+x\d+')"

scale=3
width=$(($(echo "$monitor_resolution" | cut -d 'x' -f1)))
width=$((width / scale))
height=$(($(echo "$monitor_resolution" | cut -d 'x' -f2)))
height=$((height / scale))

# Call feh (use title "float" for i3 to set window to floating. see i3 config)
feh --title "float" --geometry "$width"x"$height" --scale-down --auto-zoom \
    --action ";~/.scripts/background-setter.sh %F" \
    --action$MOVE_ACTION "$HOME/.scripts/select-folder-prompt.sh $HOME 'Destination' 'Move image to new destination' | xargs mv %F -t" \
    --action$REMOVE_ACTION "~/.scripts/remove-prompt.sh %F" \
    --action$PYWAL ";~/.scripts/wal.sh %F" "$PATHS" \
    --action$COLOR_ANALYSIS ";python ~/.scripts/color-analysis.py %F" "$PATHS"

exit 0
