#! /bin/sh
#
# dunst_launch.sh
# Created by Rolf Sievert
#

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

# Background color of low, normal, and critical notification
BACKGROUND=$(echo -lb $C0 -nb $C0 -cb $C5)

# Foreground color of low, normal, and critical notification
FOREGROUND=$(echo -lf $C9 -nf $C5 -cf $C3)

# Frame color of low, normal, and critical notification
FRAME=$(echo -frame_width 0 -lfr $C6 -nfr $C7 -cfr $C8)

# Timeout of low, normal, and critical notification
TIMEOUT=$(echo -lto 3 -nto 5 -cto 0)

# Transparency 0-100
TRANSPARENCY=$(echo transparency 20)

# Shapes
GEOMETRY=$(echo -geometry "500x120-10+40")

# Text padding
PADDING=$(echo -padding 8 -horizontal_padding 8)

# Format of notification text
# %b is body, %s is summary
# <b> </b> is for bold
FORMAT=$(echo -format "<b>%s</b>\n%b")

# Text alignment
TEXT_ALIGNMENT=$(echo -align "left")

# Icons settings
ICON=$(echo -icon_position "left" -max_icon_size 60)

# Kill and re-launch dunst
# -shrink makes the geometry shrink to text width
killall -q dunst; dunst $BACKGROUND $FOREGROUND $GEOMETRY $FRAME $FORMAT $TIMEOUT $TEXT_ALIGNMENT $TRANSPARENCY $PADDING $ICON -shrink &

echo "Dunst launched"
