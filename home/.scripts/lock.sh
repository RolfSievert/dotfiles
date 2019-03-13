#!/bin/sh

# Path to wal colors: .cache/wal/colors.Xresources

#B="color0"  # blank
#C='#ffffff22'  # clear ish
#D='#ff00ffcc'  # default
#T='#ee00eeee'  # text
#W='#880000bb'  # wrong
#V='#bb00bbbb'  # verifying

#Colors path
COL_PATH=/home/.cache/wal/colors.Xresources
B=$(echo $(awk '/\*color0:(.*)/ { print $2 }' < ~/.cache/wal/colors.Xresources)cc) # Background
C=$(echo $(awk '/\*color1:(.*)/ { print $2 }' < ~/.cache/wal/colors.Xresources)ff) # Ring color
D=$(echo $(awk '/\*color3:(.*)/ { print $2 }' < ~/.cache/wal/colors.Xresources)ff) # Date color
T=$(echo $(awk '/\*color5:(.*)/ { print $2 }' < ~/.cache/wal/colors.Xresources)ff) # Time color
W=$(echo $(awk '/\*color5:(.*)/ { print $2 }' < ~/.cache/wal/colors.Xresources)ff) # Wrong color
V=$(echo $(awk '/\*color3:(.*)/ { print $2 }' < ~/.cache/wal/colors.Xresources)ff) # Verify color

i3lock \
--insidevercolor=$B   \
--ringvercolor=$V     \
\
--insidewrongcolor=$B \
--ringwrongcolor=$W   \
\
--insidecolor=$B      \
--ringcolor=$C        \
--linecolor=$B        \
--separatorcolor=$C   \
\
--verifcolor=$T        \
--wrongcolor=$T        \
--timecolor=$T        \
--datecolor=$D        \
--layoutcolor=$T      \
--keyhlcolor=$W       \
--bshlcolor=$W        \
\
--screen 1            \
--blur 5              \
--clock               \
--indicator           \
--timestr="%H:%M:%S"  \
--datestr="%A, %m %Y" \
\
--veriftext="" \
--wrongtext="" \
--noinputtext="" \
--radius=100 \
--ring-width=8 \
--bar-indicator \
--timesize=60
#--datepos="80: 2*ty-30" \
#--timepos="ix: iy+12" \
#--datesize=20 \
# --textsize=20
# --modsize=10
# --timefont=comic-sans
# --datefont=monofur
# etc
