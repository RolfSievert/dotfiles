#! /bin/sh
#
# select-folder-prompt.sh
# Copyright (C) 2019 rolfsievert <rolfsievert@manjaro>
#
# Distributed under terms of the MIT license.
#

# Prompt to select visible folder recursively from provided path.
# Usage: ./select-folder-prompt.sh ROOT_DIR [rofi title] [rofi message]

TITLE="Select a folder"
MESSAGE=""

if [[ -z "$1" ]]; then
    echo "Search folder not provided!"
    exit 1
fi
if ! [[ -z "$2" ]]; then
    TITLE=$2
fi
if ! [[ -z "$3" ]]; then
    MESSAGE=$3
fi

ROFI_THEME=(
    -theme-str "window { width: 20%; }"
)

ROFI=(
    rofi
    -i # case insensitive
    -dmenu
    -location 0
    -p "$TITLE"
    #-kb-cancel 'Super_L,Escape'
)
# Add message if provided
if ! [[ -z "$MESSAGE" ]]; then
    ROFI+=(-mesg "$MESSAGE")
fi

ROOT_DIR=$1
FOLDERS=$(cd "$ROOT_DIR" && find * -not -path '*/\.*' -type d)

RESULT=$(echo "$FOLDERS" | "${ROFI[@]}" "${ROFI_THEME[@]}")

# only print if any selection was made
if ! [[ -z "$RESULT" ]]; then
    echo $ROOT_DIR/$RESULT
fi
