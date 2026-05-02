#! /usr/bin/env sh
#
# dunst_launch.sh
#

# Kill and re-launch dunst
killall -q dunst; dunst -config "$HOME"/.cache/wal/dunstrc &

echo "Dunst launched"
