#! /usr/bin/env bash

# Arbitrary but unique message id
msgId="991052"

OPTIONS=(
    "se" 
    "us"
)

if ! [[ $# -eq 0 ]]; then
    # Arguments supplied
    OPTIONS=( "$@" )
fi

current_layout=$(setxkbmap -query | grep layout | tr -s ' ' | cut -d ' ' -f2)

for i in "${!OPTIONS[@]}"; do
   if [[ "${OPTIONS[$i]}" = "${current_layout}" ]]; then
           new_index=$(((i + 1) % ${#OPTIONS[@]}))
       break
   fi
done

new_layout="${OPTIONS[new_index]}"
setxkbmap "$new_layout"

# Send the notification, -r is int reference value
dunstify --app-name=custom-bar -u normal --icon=0 -r "$msgId" "Keyboard language ($new_layout)"
