#! /bin/sh
#
# select-folder-prompt.sh
# Copyright (C) 2019 rolfsievert <rolfsievert@manjaro>
#
# Distributed under terms of the MIT license.
#

# Prompt to select visible folder recursively from provided path.
# Usage: ./select-folder-prompt.sh ROOT_DIR [rofi title] [rofi message]

TITLE="Folder"
MESSAGE="Select a folder"

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

ROOT_DIR=$1
find $ROOT_DIR -not -path '*/\.*' -type d | rofi -i -dmenu -mesg "$MESSAGE" -p "$TITLE"
