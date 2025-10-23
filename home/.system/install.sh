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
HOOKS="$ROOT"/pacman_hooks
GENERATED_HOOKS="$ROOT"/.generated_hooks
HOOKS_DESTINATION="/etc/pacman.d/hooks"

found_issues=0
dry_run=0

if [[ "${1:-}" == "--dry-run" ]]; then
    dry_run=1
fi

# Create missing hooks destination directory
if [[ ! -d "$HOOKS_DESTINATION" ]]; then
    echo
    echo "Creating missing hooks directory $HOOKS_DESTINATION... (requires sudo)"
    sudo mkdir -p $HOOKS_DESTINATION
fi

# Create hooks with injected variables
mkdir -p "$GENERATED_HOOKS"
for src_hook in "$HOOKS"/*.hook; do
    # If there were no matches, the glob expands to the literal pattern;
    # skip that case so you don’t try to process a non‑existent file.
    [[ -e "$src_hook" ]] || continue

    envsubst < "$src_hook" > "$GENERATED_HOOKS/$(basename $src_hook)"
done

read -r -a outdated_hooks <<< $($SCRIPTS/directory_diff.sh $GENERATED_HOOKS $HOOKS_DESTINATION)
if [[ ${#outdated_hooks[@]} -gt 0 ]]; then
    echo "Outdated pacman hooks:"
    for f in "${outdated_hooks[@]}"; do
        printf " - $f"
    done
    printf "\n"

    found_issues=1

    if ! (( dry_run )); then
        echo
        read -p "Update outdated pacman hooks? " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            for fname in "${outdated_hooks[@]}"; do
                src_origin="$HOOKS/$fname"
                src_path="$GENERATED_HOOKS/$fname"
                dst_path="$HOOKS_DESTINATION/$fname"

                if [[ -e "$src_path" ]]; then
                    # Copy preserving mode, timestamps, and (optionally) ownership
                    if sudo cp "$src_path" "$dst_path"; then
                        printf " - ✅ Updated $src_origin -> $dst_path\n"
                    fi
                else
                    echo "⚠️ Skipping – failed to copy source: $src_origin"
                fi
            done
        fi
    fi
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
                src_origin="$HOOKS/$fname"
                src_path="$GENERATED_HOOKS/$fname"
                dst_path="$HOOKS_DESTINATION/$fname"

                if [[ -e "$src_path" ]]; then
                    # Copy preserving mode, timestamps, and (optionally) ownership
                    if sudo cp "$src_path" "$dst_path"; then
                        printf " - ✅ Copied $src_origin -> $dst_path\n"
                    fi
                else
                    echo "⚠️ Skipping – failed to copy source: $src_origin"
                fi
            done
        fi
    fi
fi

# Cleanup
rm -r "$GENERATED_HOOKS"

if (( found_issues )) && (( dry_run )); then
    exit 1
    echo
else
    exit 0
fi
