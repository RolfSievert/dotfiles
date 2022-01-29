#! /bin/sh
#
# notes.sh
#

EDITOR=nvim

ROFI_THEME=(
    -theme-str 'window { width: 16%; }'
    #-theme-str 'listview { lines: 0; }'
    -theme-str 'element-text { horizontal-align: 0.5; }'
    -theme-str 'entry { horizontal-align: 0.5; }'
    -theme-str 'inputbar { children: [ entry,case-indicator ]; }'
)

ROFI_OPTIONS=(
    -i # case insensitive searches
    -dmenu
    -kb-cancel 'Super_L,Escape'
)

NOTES_ROOT="$HOME/Notes"

OPTIONS=(
    "Create new note"
)

# create folder if it doesn't exist
mkdir -p $NOTES_ROOT

NOTES=$(ls $NOTES_ROOT)

LIST_ITEMS=$OPTIONS
LIST_ITEMS+=(${NOTES[@]})
LIST_LENGTH=$(echo ${#LIST_ITEMS[@]})

# -p for prompt
SELECTION=`printf '%s\n' "${LIST_ITEMS[@]}" | rofi -kb-cancel 'Super_L,Escape' "${ROFI_OPTIONS[@]}" "${ROFI_THEME[@]}" -theme-str "listview { lines: $LIST_LENGTH; }" -p "Open note"`

get_note_name () {
    local note_name=`rofi -dmenu "${ROFI_THEME[@]}" -theme-str 'listview { lines: 0; }' -p "Enter new note name (no suffix)"`
    echo "$note_name"
}

if [[ "$SELECTION" == ${OPTIONS[0]} ]]; then
    # open prompt to create a new note
    note_name="$(get_note_name)"
    new_note_path=$NOTES_ROOT/$note_name.md
    alacritty --class notes -e $SHELL -ic "$EDITOR $new_note_path"
elif [[ ! -z "${SELECTION// }" ]]; then # if not empty excluding spaces
    alacritty --class notes -e $SHELL -ic "$EDITOR $NOTES_ROOT/$SELECTION"
fi
