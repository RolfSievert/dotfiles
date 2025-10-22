#!/usr/bin/env bash

# TODO:
# - new versions of pkgbuilds based on github
# - if pacman install hook is active
# - memory allocation status
# - check that config and all such files are symlinked to home dir
# - copy pacman install hooks (that adds new packages to the general.txt file in packages)
# - list and install package files

ROOT=$(dirname $0)
SCRIPTS="$ROOT"/scripts
HOOKS="./pacman_hooks"
HOOKS_DESTINATION="/etc/pacman.d/hooks"

found_issues=0
dry_run=0

if [[ "${1:-}" == "--dry-run" ]]; then
    dry_run=1
fi

read -r -a missing_hooks <<< $("$SCRIPTS"/files_not_in_directory.sh $HOOKS $HOOKS_DESTINATION)

# Install pacman hooks
if [[ ${#missing_hooks[@]} -gt 0 ]]; then
    echo "Missing pacman hooks:"
    for f in "${missing_hooks[@]}"; do
        printf " - $f"
    done
    printf "\n"

    found_issues=1

    if ! (( dry_run )); then
        echo
        read -p "Add missing pacman hooks? " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            for fname in "${missing_hooks[@]}"; do
                src_path="$HOOKS/$fname"
                dst_path="$HOOKS_DESTINATION/$fname"

                if [[ -e "$src_path" ]]; then
                    # Copy preserving mode, timestamps, and (optionally) ownership
                    if envsubst < "$src_path" | sudo tee "$dst_path" > /dev/null; then
                        printf " - ✅ Copied $src_path -> $dst_path\n"
                    fi
                else
                    echo "⚠️ Skipping – source file not found: $src_path"
                fi
            done
        fi
    fi
fi


if (( found_issues )) && (( dry_run )); then
    exit 1
    echo
else
    exit 0
fi
