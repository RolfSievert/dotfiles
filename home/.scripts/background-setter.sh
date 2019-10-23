#! /bin/sh
#
# background-setter.sh
#
# Aspectcrop script: (thanks fred)
# http://www.fmwconcepts.com/imagemagick/aspectcrop/index.php

# Set background with feh --bg-fill, but image is cropped beforehand as desired if not matching screen proportions.

function gcd {
    # Calculate gcd of two numbers
    dividend=$1
    divisor=$2

    remainder=1

    until [ "$remainder" -eq 0 ]; do
        let "remainder = $dividend % $divisor"
        dividend=$divisor
        divisor=$remainder
    done
    echo $dividend
}

function get_aspect_ratio {
    WIDTH=$1
    HEIGHT=$2
    tmp=`gcd $WIDTH $HEIGHT`
    R_W=$((WIDTH / tmp))
    R_H=$((HEIGHT / tmp))
    echo $R_W $R_H
}

function get_monitor_aspect_ratio {
    # Get resolution
    res=`xdpyinfo | grep dimensions | sed -r 's/^[^0-9]*([0-9]+x[0-9]+).*$/\1/'`
    # Split height and width on 'x'
    res=(${res//x/ })
    WIDTH=${res[0]}
    HEIGHT=${res[1]}
    # Get aspect ratio
    AR=`get_aspect_ratio $WIDTH $HEIGHT`
    echo $AR
}

IMAGE=$1
SAVE_PATH="$HOME/.bg"

# Check screen proportions
# Aspect ratio of monitor
MON_AR=`get_monitor_aspect_ratio`
# Aspect ratio of image
PIC_DIM=`magick identify -format "%wx%h" $IMAGE`
PIC_DIM=(${PIC_DIM//x/ })
PIC_AR=`get_aspect_ratio ${PIC_DIM[@]}`

# If screen proportions are equal to image, set bg and return
if [[ "${MON_AR[@]}" == "${PIC_AR[@]}" ]]; then
    feh --bg-fill $IMAGE
    exit
fi

# Prompt to select alignment
# Options: center, top, bottom, left, right
OPTIONS=(Center Top Bottom Left Right)
SELECTED="$(printf '%s\n' "${OPTIONS[@]}" | rofi -dmenu -mesg "Select alignment of background image." -p "alignment")"

# Crop image and save copy (if selection is valid, otherwise cancel operation)
# Path to aspect crop script
ASPECTCROP=~/.scripts/aspectcrop.sh
NO_END="${IMAGE%.*}"
EXTENSION="${IMAGE##*.}"
case "$SELECTED" in
    "Center")
        feh --bg-fill $IMAGE
        ;;
    "Top")
        $ASPECTCROP -a "${MON_AR// /:}" -g n "$IMAGE" "$SAVE_PATH.$EXTENSION"
        feh --bg-fill "$SAVE_PATH.$EXTENSION"
        ;;
    "Bottom")
        $ASPECTCROP -a "${MON_AR// /:}" -g s "$IMAGE" "$SAVE_PATH.$EXTENSION"
        feh --bg-fill "$SAVE_PATH.$EXTENSION"
        ;;
    "Left")
        $ASPECTCROP -a "${MON_AR// /:}" -g w "$IMAGE" "$SAVE_PATH.$EXTENSION"
        feh --bg-fill "$SAVE_PATH.$EXTENSION"
        ;;
    "Right")
        $ASPECTCROP -a "${MON_AR// /:}" -g e "$IMAGE" "$SAVE_PATH.$EXTENSION"
        feh --bg-fill "$SAVE_PATH.$EXTENSION"
        ;;
    *)
        # Cancel operation
        exit
esac
