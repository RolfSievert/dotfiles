#!/usr/bin/env bash
#
# Takes a file and lists it without comments.
#

set -euo pipefail

FILE="$1"

if ! [[ -f "$FILE" ]]; then
    echo "'$FILE' is NOT a regular file (or does not exist)." >&2
    exit 1
fi

grep "^[^#]" "$FILE"
