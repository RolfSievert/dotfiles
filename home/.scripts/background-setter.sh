#! /bin/sh
#
# background-setter.sh
#

gcd() {
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

getAspectRatio() {
    width=$1
    height=$2
    tmp=`gcd $width $height`
    R_W=$((width / tmp))
    R_H=$((height / tmp))
    echo $R_W $R_H
}

primaryMonitorAspectRatio() {
    # Get resolution
    res="$(xrandr | grep 'connected primary' | grep -Po '\d+x\d+')"
    # Split height and width on 'x'
    res=(${res//x/ })
    width=${res[0]}
    height=${res[1]}
    # Get aspect ratio
    aspectRatio=$(getAspectRatio $width $height)
    echo $aspectRatio
}

contains() {
    local match=$1
    local array=$2

    for el in "${array[@]}"; do
        if [[ "$match" == "$el" ]]; then
            echo 1
            return
        fi
    done

    echo 0
}

setBackground() {
    local imgPath=$1
    if [[ "$XDG_CURRENT_DESKTOP" == "GNOME" ]]; then
        gsettings set org.gnome.desktop.background picture-uri "file://$imgPath"
        gsettings set org.gnome.desktop.background picture-uri-dark "file://$imgPath"
    else
        feh --bg-fill "$imgPath"
    fi
}

if [[ $# -eq 0 ]]; then
    echo 'Missing image path argument.'
    exit 1
elif [[ -z "$(command -v rofi)" ]]; then
    echo 'Command "rofi" is not available!'
    exit 1
fi

IMAGE=$1
SAVE_PATH="$HOME/.bg"
EXTENSION="${IMAGE##*.}"
background_path="$SAVE_PATH.$EXTENSION"

# Check screen proportions
# Aspect ratio of monitor
MON_AR=$(primaryMonitorAspectRatio)
# Aspect ratio of image
PIC_DIM=$(magick identify -format "%wx%h" "$IMAGE")
PIC_DIM=(${PIC_DIM//x/ })
PIC_AR=$(getAspectRatio ${PIC_DIM[@]})

# If screen proportions are equal to image, set bg and return
if [[ "${MON_AR[@]}" == "${PIC_AR[@]}" ]]; then
    cp "$IMAGE" "$background_path"
    setBackground "$background_path"
    echo "$IMAGE"
    exit 0
fi

# Prompt to select alignment
gravity_options=(center north west south east northeast northwest southwest southeast)
gravity="$(printf '%s\n' "${gravity_options[@]}" | rofi -dmenu -mesg "Select alignment of background image." -p "alignment")"

# Crop image and save copy (if selection is valid, otherwise cancel operation)
# Path to aspect crop script
ASPECTCROP=~/.scripts/aspectcrop.sh

if [[ "$gravity" == "center" ]]; then
    cp "$IMAGE" "$background_path"
elif [[ $(contains "$gravity" "${gravity_options[@]}") ]]; then
    $ASPECTCROP -a "${MON_AR// /:}" -g "$gravity" "$IMAGE" "$background_path"
else
    # Cancel operation
    exit 0
fi

setBackground "$background_path"
echo "$IMAGE"
exit 0

