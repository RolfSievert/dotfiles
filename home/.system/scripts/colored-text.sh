#!/usr/bin/env bash

# print a text in intense colors (8-15) in colorscheme
colored_intense_text() {
    # index can range from 0-7, mapping to terminal colorscheme
    local color_index="$1"
    shift
    local txt="$*"
    # use "\033[9<n>m" for intense colors (8-15 in colorscheme)
    local color_start="\033[9${color_index}m"
    local color_end="\033[0m"
    printf '%b%s%b' "$color_start" "$txt" "$color_end"
}

# print a text in normal colors (0-7) in colorscheme
colored_text() {
    # index can range from 0-7, mapping to terminal colorscheme
    local color_index="$1"
    shift
    local txt="$*"
    # use "\033[3<n>m" for normal colors (0-7 in colorscheme)
    local color_start="\033[3${color_index}m"
    local color_end="\033[0m"
    printf '%b%s%b' "$color_start" "$txt" "$color_end"
}

# print an alert message with newline
alert_nl() {
    local txt="$*"
    local color_index="4"
    # 38;5;<n>  → set foreground colour to colour number <n>
    # 208 is a bright orange in the 256‑colour palette.
    printf '%s\n' "$(colored_text "$color_index" "$txt")"
}

# print a warning message with newline
warning_nl() {
    local txt="$*"
    local color_index="2"
    # 38;5;<n>  → set foreground colour to colour number <n>
    # 208 is a bright orange in the 256‑colour palette.
    printf '%s\n' "$(colored_text "$color_index" "$txt")"
}

# print an info message with newline
info_nl() {
    local txt="$*"
    local color_index="5"
    # 38;5;<n>  → set foreground colour to colour number <n>
    # 208 is a bright orange in the 256‑colour palette.
    printf '%s\n' "$(colored_text "$color_index" "$txt")"
}

# print a note (not so important) message with newline
note_nl() {
    local txt="$*"
    local color_index="0"
    # 38;5;<n>  → set foreground colour to colour number <n>
    # 208 is a bright orange in the 256‑colour palette.
    printf '%s\n' "$(colored_intense_text "$color_index" "$txt")"
}

export -f alert_nl
export -f warning_nl
export -f info_nl
