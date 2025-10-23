#!/usr/bin/env bash
# Takes a file and lists it without comments, outputting a single
# space‑separated line.

set -euo pipefail

FILE="${1:?missing file argument}"

# ------------------------------------------------------------------
# 1. Verify the argument is a regular file
# ------------------------------------------------------------------
if [[ ! -f "$FILE" ]]; then
    echo "'$FILE' is NOT a regular file (or does not exist)." >&2
    exit 1
fi

# ------------------------------------------------------------------
# 2. Drop comment lines (both "#…" and "\#…") and collapse newlines
# ------------------------------------------------------------------
grep -v '^[[:space:]]*\(#\|\\#\)' "$FILE" |   # keep only non‑comment lines
tr '\n' ' ' |                                 # turn newlines into spaces
sed 's/[[:space:]]\+$//'                      # strip trailing space (optional)
