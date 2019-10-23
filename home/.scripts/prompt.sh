#! /bin/sh
#
# prompt.sh
#

# Opens a rofi prompt and returns input.
# Usage: ./prompt.sh [title] [message]

TITLE="Enter text"
MESG=""

# Check if title provided
if ! [[ -z "$1" ]]; then
    TITLE="$1"
fi
# Check if message provided
if ! [[ -z "$2" ]]; then
    MESG="$2"
fi

# No message provided
if [[ -z "$MESG" ]]; then
    rofi -dmenu -p "$TITLE"
else
    rofi -dmenu -p "$TITLE" -mesg "$MESG"
fi
