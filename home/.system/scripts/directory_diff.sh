#!/usr/bin/env bash
# ------------------------------------------------------------
# Usage: ./diff‑common‑files.sh  /path/to/first  /path/to/second
#
# Prints the filenames that exist in BOTH directories
# but whose file contents are NOT identical.
# ------------------------------------------------------------

set -euo pipefail   # safety: exit on error, undefined var, pipeline failures

# ---------- Argument validation ----------
if (( $# != 2 )); then
    echo "Error: exactly two directory arguments required." >&2
    echo "Usage: $0 <dir1> <dir2>" >&2
    exit 1
fi

DIR1=$1
DIR2=$2

# Ensure both arguments are readable directories
for d in "$DIR1" "$DIR2"; do
    if [[ ! -d "$d" ]]; then
        echo "Error: '$d' is not a directory or does not exist." >&2
        exit 1
    fi
done

# ---------- Core logic ----------
# Loop over the *basename* of every regular file in DIR1.
# Using `find -maxdepth 1 -type f` limits us to the top level only.
# (Remove `-maxdepth 1` if you want to recurse into sub‑folders.)

while IFS= read -r -d '' file1; do
    name=$(basename "$file1")
    file2="$DIR2/$name"

    # Does a file with the same name exist in DIR2?
    if [[ -f "$file2" ]]; then
        # Compare contents.  `cmp -s` returns 0 when files are identical,
        # non‑zero otherwise.  We suppress output with `-s`.
        if ! cmp -s "$file1" "$file2"; then
            echo "$name"
        fi
    fi
done < <(find "$DIR1" -maxdepth 1 -type f -print0)
