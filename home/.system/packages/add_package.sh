#! /bin/bash

# -------------------------------------------------
# Usage: ./add_package.sh <file> <package>
# -------------------------------------------------
# <file> – path to the text file you want to modify
# <package> – a single package to append
#
# The script checks whether <package> already appears
# anywhere in <file>. If it doesn’t, the package is
# appended (on its own line) and the file is left
# unchanged otherwise.
# -------------------------------------------------

set -euo pipefail   # safer scripting

# ---- Argument validation -----------------------------------------
if [[ $# -ne 1 ]]; then
    echo "Error: Exactly one arguments required."
    echo "Usage: $0 <file>"
    exit 1
fi

FILE=$1
PACKAGE=$(cat /var/log/pacman.log | grep " installed " | tail -n1 | awk '{print $4}')

# Ensure the package name contains no whitespace
if [[ "$PACKAGE" =~ [[:space:]] ]]; then
    echo "Error: The package name must not contain whitespace."
    exit 1
fi

# Make sure the file exists
if [[ ! -e "$FILE" ]]; then
    echo "Error: File '$FILE' does not exist."
    exit 1
fi

# ---- Core logic --------------------------------------------------
# Grep for the exact package (as a whole token). The -w flag
# matches whole words, and -F treats the pattern literally.
if grep -qwF -- "$PACKAGE" "$FILE"; then
    # Package already present – do nothing
    echo "The package '$PACKAGE' is already in '$FILE'. No changes made."
else
    # Append the package on a new line
    echo "$PACKAGE" >> "$FILE"
    echo "Appended '$PACKAGE' to '$FILE'."
fi
