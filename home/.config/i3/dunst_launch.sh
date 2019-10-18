#! /bin/sh
#
# dunst_launch.sh
# Copyright (C) 2019 rolfsievert <rolfsievert@manjaro>
#
# Distributed under terms of the MIT license.
#

# Kill running dunst


#Colors path
COL_PATH=/home/.cache/wal/colors.Xresources
C0=$(echo $(awk '/\*color0:(.*)/ { print $2 }' < ~/.cache/wal/colors.Xresources)) # Background
C1=$(echo $(awk '/\*color1:(.*)/ { print $2 }' < ~/.cache/wal/colors.Xresources)) # Ring color
C2=$(echo $(awk '/\*color2:(.*)/ { print $2 }' < ~/.cache/wal/colors.Xresources)) # Date color
C3=$(echo $(awk '/\*color3:(.*)/ { print $2 }' < ~/.cache/wal/colors.Xresources)) # Time color
C4=$(echo $(awk '/\*color4:(.*)/ { print $2 }' < ~/.cache/wal/colors.Xresources)) # Wrong color
C5=$(echo $(awk '/\*color5:(.*)/ { print $2 }' < ~/.cache/wal/colors.Xresources)) # Verify color
C6=$(echo $(awk '/\*color6:(.*)/ { print $2 }' < ~/.cache/wal/colors.Xresources)) # Verify color
C7=$(echo $(awk '/\*color7:(.*)/ { print $2 }' < ~/.cache/wal/colors.Xresources)) # Verify color
C8=$(echo $(awk '/\*color8:(.*)/ { print $2 }' < ~/.cache/wal/colors.Xresources)) # Verify color

# Foreground color of low, normal, and critical notification
FOREGROUND=$(echo -lf $C0 -nf $C1 -cf $C2)

# Background color of low, normal, and critical notification
#BACKGROUND=$(echo -lb $C3 -nb $C4 -cb $C5)

# Frame color of low, normal, and critical notification
FRAME=$(echo -lfr $C6 -nfr $C7 -cfr $C8)

# Timeout of low, normal, and critical notification

# Transparency 0-100
TRANSPARENCY=$(echo transparency 90)

# Kill and re-launch dunst
#killall -q dunst; dunst $FOREGROUND $BACKGROUND $FRAME $TRANSPARENCY &
killall -q dunst; dunst $FOREGROUND $FRAME $TRANSPARENCY &

echo "Dunst launched"
