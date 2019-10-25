#!/bin/sh

# Usage: ./wal.sh IMAGE_PATH [backend] [saturation]

if [ -z "$1" ]; then
    echo "No image path provided!"
    exit 1
fi

IMAGE=$1
# saturation
S=($(seq 0 0.05 1))
# Backend
B=""

# Backends: colorz, schemer2, haishoku, colorthief, wal
BACKENDS=(wal colorthief haishoku colorz)

if [ ! -z "$2" ]; then
    # Check if value exists in array of backends
    if [[ " ${BACKENDS[@]} " =~ " $2 " ]]; then
        B=$2
    else
        echo "Not a valid backend!"
        exit 1
    fi
else
    # Get backend with rofi prompt
    B=`printf '%s\n' "${BACKENDS[@]}" | rofi -dmenu -p "Backend" -mesg "Select backend for colorscheme generation"`
    if [ -z "$B" ]; then
        echo "Operation canceled."
        exit 0
    fi
fi

if [ -z "$3" ]; then
    S=`printf '%s\n' ${S[@]} | rofi -dmenu -p "Saturation" -mesg "Enter a saturation value for wal."`
else
    S=$3
fi

wal -n -i "$IMAGE" --saturate "$S" --backend "$B" > /dev/null

#oomox-cli -m all ~/.cache/wal/colors-oomox
