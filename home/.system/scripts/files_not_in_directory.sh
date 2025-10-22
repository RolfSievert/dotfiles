#!/usr/bin/env bash

# -------------------------------------------------
# Lists files in source dir not in target dir
# -------------------------------------------------
# Usage: ./diff_files.sh <source> <target>
#   source – source directory (files to check)
#   target – reference directory (files to exclude)
# -------------------------------------------------

# Exit on any error
set -euo pipefail

# Validate arguments
if [[ $# -ne 2 ]]; then
    echo "Error: exactly two directory arguments required."
    echo "Usage: $0 <source_dir> <target_dir>"
    exit 1
fi

src_dir="$1"
target_dir="$2"

# Ensure both arguments are directories
if [[ ! -d "$src_dir" ]]; then
    echo "Error: source directory \"$src_dir\" does not exist or is not a directory."
    exit 1
fi
if [[ ! -d "$target_dir" ]]; then
    echo "Error: reference directory \"$target_dir\" does not exist or is not a directory."
    exit 1
fi

# Declare the result array
declare -a unique_files=()

# Iterate over all regular files in the source directory (recursively)
while IFS= read -r -d '' file_path; do
    # Strip the leading source directory part to get a relative path
    rel_path="${file_path#$src_dir/}"

    # Check if a file with the same relative path exists in the reference directory
    if [[ ! -e "$target_dir/$rel_path" ]]; then
        unique_files+=("$rel_path")
    fi
done < <(find "$src_dir" -type f -print0)

printf '%s\n' "$(printf '%s ' "${unique_files[@]}")"
