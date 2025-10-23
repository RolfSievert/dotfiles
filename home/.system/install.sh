#!/usr/bin/env bash

# TODO:
# - new versions of pkgbuilds based on github
# - memory allocation status
# - check that config and all such files are symlinked to home dir
# - add pipx and flathub package lists? How to make the correct installer run them?

ROOT=$(dirname "$0")
SCRIPTS="$ROOT/scripts"
HOOKS="$ROOT/pacman_hooks"
GENERATED_HOOKS="$ROOT/.generated_hooks"
HOOKS_DESTINATION="/etc/pacman.d/hooks"
PACKAGES_DIR="$ROOT/packages"

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

    fname=$(basename "$src_hook")
    envsubst < "$src_hook" > "$GENERATED_HOOKS/$fname"
done

# Update outdated pacman hooks
read -r -a outdated_hooks <<< "$("$SCRIPTS"/directory_diff.sh "$GENERATED_HOOKS" "$HOOKS_DESTINATION")"
if [[ ${#outdated_hooks[@]} -gt 0 ]]; then
    echo "Outdated pacman hooks:"
    for f in "${outdated_hooks[@]}"; do
        printf " - %s" "$f"
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
                        printf " - ✅ Updated %s -> %s\n" "$src_origin" "$dst_path"
                    fi
                else
                    echo "⚠️ Skipping – failed to copy source: $src_origin"
                fi
            done
        fi
    fi
fi

read -r -a missing_hooks <<< "$("$SCRIPTS"/files_not_in_directory.sh "$HOOKS" "$HOOKS_DESTINATION")"

# Install pacman hooks
if [[ ${#missing_hooks[@]} -gt 0 ]]; then
    echo "Missing pacman hooks:"
    for f in "${missing_hooks[@]}"; do
        printf " - %s" "$f"
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
                        printf " - ✅ Copied %s -> %s\n" "$src_origin" "$dst_path"
                    fi
                else
                    echo "⚠️ Skipping – failed to copy source: $src_origin"
                fi
            done
        fi
    fi
fi


# Check if all packages are installed
for pack in "$PACKAGES_DIR"/*.txt; do
    packages_raw=$( "$SCRIPTS"/list_packages.sh "$pack" )
    readarray -t packages <<< "$packages_raw"
    readarray -t uninstalled_packages <<< "$("$SCRIPTS"/filter_uninstalled_packages.sh "${packages[@]}")"

    # Even if the result is empty, it will have a count of 1 for some reason
    # (probably whitespace). Check if the result is empty and skip that case.
    if [[ -z "${uninstalled_packages[*]}" ]]; then
        continue
    fi

    # list is empty
    if [[ ${#uninstalled_packages[@]} -lt 1 ]]; then
        continue
    fi

    found_issues=1

    count="${#uninstalled_packages[@]}"
    echo
    echo "Package list '$(basename "$pack")' contains $count packages not installed on this system:"
    for package in "${uninstalled_packages[@]}"; do
        echo " - $package"
    done

    if (( dry_run )); then
        continue
    fi

    echo
    read -p "Install these packages? " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        yay -S "${uninstalled_packages[*]}"
    fi
done


# Cleanup
rm -r "$GENERATED_HOOKS"

if (( found_issues )) && (( dry_run )); then
    exit 1
else
    exit 0
fi
