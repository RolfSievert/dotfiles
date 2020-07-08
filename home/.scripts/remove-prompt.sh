#! /bin/sh
#
# prompt.sh
#

# Opens a rofi prompt that asks to remove a file.
# Usage: ./prompt.sh file [MESSAGE]

TITLE="Remove file?"
MESG=""

# Check if message provided
if [[ -z "$1" ]]; then
    echo "Error: File not provided to remove-prompt.sh"
    exit 1
fi
# Check if message provided
if ! [[ -z "$2" ]]; then
    MESG="$2"
fi

# No message provided
if [[ -z "$MESG" ]]; then
    SELECTION=`printf "yes\nno" | rofi -dmenu -p "$TITLE"`
else
    SELECTION=`printf "yes\nno" | rofi -dmenu -p "$TITLE" -mesg "$MESG"`
fi

if [[ "$SELECTION" == "yes" ]]; then
    rm "$1"
fi
