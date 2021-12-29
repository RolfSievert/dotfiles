#! /bin/sh
#
# dunst_launch.sh
#

# Old Icons settings, still usable?
ICON=$(echo -icon_position "left" -max_icon_size 60 -icon_path "/usr/share/icons/Papirus/32x32/status/:/usr/share/icons/gnome/32x32/status/")

# Kill and re-launch dunst
killall -q dunst; dunst -config $HOME/.cache/wal/dunstrc &

echo "Dunst launched"
