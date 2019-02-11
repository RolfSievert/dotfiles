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
B=$(echo $(awk '/\*color0:(.*)/ { print $2 }' < ~/.cache/wal/colors.Xresources)cc)
C=$(echo $(awk '/\*color0:(.*)/ { print $2 }' < ~/.cache/wal/colors.Xresources)ff)
D=$(echo $(awk '/\*color2:(.*)/ { print $2 }' < ~/.cache/wal/colors.Xresources)ff)
T=$(echo $(awk '/\*color4:(.*)/ { print $2 }' < ~/.cache/wal/colors.Xresources)ff)
W=$(echo $(awk '/\*color5:(.*)/ { print $2 }' < ~/.cache/wal/colors.Xresources)ff)
V=$(echo $(awk '/\*color3:(.*)/ { print $2 }' < ~/.cache/wal/colors.Xresources)ff)


i3lock \
--insidevercolor=$C   \
--ringvercolor=$V     \
\
--insidewrongcolor=$C \
--ringwrongcolor=$W   \
\
--insidecolor=$B      \
--ringcolor=$D        \
--linecolor=$B        \
--separatorcolor=$D   \
\
--verifcolor=$T        \
--wrongcolor=$T        \
--timecolor=$T        \
--datecolor=$T        \
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
\ #--keylayout 2         \
\
--veriftext="...Maybe..." \
--wrongtext="Nope!" 
# --textsize=20
# --modsize=10
# --timefont=comic-sans
# --datefont=monofur
# etc
