#!/usr/bin/env bash

# TODO:
# - memory allocation status
# - add pipx and flathub package lists? How to make the correct installer run them?
# - add colors:
#   - issues headings (like uninstalled packages list): warning / orange
#   - actions like copying files: info / blue
#   - unfocused text: gray

ROOT=$(dirname "$0")
DOTFILES_ROOT="$ROOT"/..
SCRIPTS="$ROOT"/scripts
HOOKS="$ROOT"/pacman_hooks
GENERATED_HOOKS="$ROOT"/.generated_hooks
HOOKS_DESTINATION="/etc/pacman.d/hooks"
PACKAGES_DIR="$ROOT"/packages
GIT_HOOKS_PATH="$(git rev-parse --show-toplevel)"/.githooks

source "$ROOT"/scripts/colored-text.sh

found_issues=0
dry_run=0

if [[ "${1:-}" == "--dry-run" ]]; then
    dry_run=1
fi

current_git_hooks_path=$(git config core.hooksPath)
if [[ $(realpath "$current_git_hooks_path") != $(realpath "$GIT_HOOKS_PATH") ]]; then
    echo
    alert_nl "Git hooks are not setup, i.e. the system status will not be checked automatically when changes are made."

    if [[ -n "$current_git_hooks_path" ]]; then
        note_nl " - Current hook: $(realpath "$current_git_hooks_path")"
    fi

    if ! (( dry_run )); then
        echo
        read -p "Setup git hooks for this repo? " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            git config core.hooksPath "$GIT_HOOKS_PATH"
            info_nl "New git hook directory: $(realpath GIT_HOOKS_PATH)"
        fi
    fi
fi

# Create missing hooks destination directory
if [[ ! -d "$HOOKS_DESTINATION" ]]; then
    echo
    info_nl "Creating missing hooks directory $HOOKS_DESTINATION... (requires sudo)"
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
    echo
    warning_nl "Outdated pacman hooks:"
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
                        info_nl "$(printf " - ✅ Updated %s -> %s" "$src_origin" "$dst_path")"
                    fi
                else
                    alert_nl "⚠️ Skipping – failed to copy source: $src_origin"
                fi
            done
        fi
    fi
fi

read -r -a missing_hooks <<< "$("$SCRIPTS"/files_not_in_directory.sh "$HOOKS" "$HOOKS_DESTINATION")"

# Install pacman hooks
if [[ ${#missing_hooks[@]} -gt 0 ]]; then
    echo
    warning_nl "Missing pacman hooks:"
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
                        info_nl "$(printf " - ✅ Copied %s -> %s\n" "$src_origin" "$dst_path")"
                    fi
                else
                    alert_nl "⚠️ Skipping – failed to copy source: $src_origin"
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
    warning_nl "Package list '$(basename "$pack")' contains $count packages not installed on this system:"
    for package in "${uninstalled_packages[@]}"; do
        note_nl " - $package"
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

# Check that all files are symlinked
readarray -t dotfiles <<< "$(ls -A "$DOTFILES_ROOT")"
missing_symlinks=()
for file in "${dotfiles[@]}"; do
    symlink_path="$HOME/$(basename "$file")"
    src_path="$DOTFILES_ROOT/$file"
    if ! [ -L "$symlink_path" ]; then
        missing_symlinks+=("$(realpath "$src_path")")
    elif [[ "$(realpath "$symlink_path")" != "$(realpath "$src_path")" ]]; then
        # if the symlink points to another path, add that as well
        missing_symlinks+=("$(realpath "$src_path")")
    fi
done
if [[ ${#missing_symlinks[@]} -gt 0 ]]; then
    found_issues=1

    echo
    warning_nl "Missing symlinks in '$HOME':"
    for file in "${missing_symlinks[@]}"; do
        file_type="file"
        if [[ -d "$file" ]]; then
            file_type="directory"
        fi
        echo " - $(basename "$file") ($file_type)"
    done

    if ! (( dry_run )); then
        echo
        read -p "Symlink files & directories to '$HOME/'? " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            for file in "${missing_symlinks[@]}"; do
                symlink_path="$HOME/$(basename "$file")"

                # symlink file
                if [[ -f "$file" ]]; then
                    if [[ -L "$symlink_path" ]]; then
                        echo
                        read -p "A symlink already exists at '$symlink_path' (-> $(realpath "$symlink_path")), replace it? " -n 1 -r
                        echo
                        if [[ $REPLY =~ ^[Yy]$ ]]; then
                            ln -s -f --no-target-directory "$file" "$symlink_path"
                        else
                            continue
                        fi
                    elif [[ -f "$symlink_path" ]]; then
                        echo
                        read -p "File already exists at '$symlink_path', replace? Cannot be undone! " -n 1 -r
                        echo
                        if [[ $REPLY =~ ^[Yy]$ ]]; then
                            ln -s -f "$file" "$symlink_path"
                        else
                            continue
                        fi
                    else
                        ln -s "$file" "$symlink_path"
                    fi
                # symlink directory
                elif [[ -d "$file" ]]; then
                    if [[ -L "$symlink_path" ]]; then
                        echo
                        read -p "A symlink already exists at '$symlink_path' (-> $(realpath "$symlink_path")), replace it? " -n 1 -r
                        echo
                        if [[ $REPLY =~ ^[Yy]$ ]]; then
                            ln -s -f --no-target-directory "$file" "$symlink_path"
                        else
                            continue
                        fi
                    elif [[ -d "$symlink_path" ]]; then
                        echo
                        read -p "Directory already exists at '$symlink_path', do you want to merge directories (overlapping files will be removed)? Cannot be undone! " -n 1 -r
                        echo
                        if [[ $REPLY =~ ^[Yy]$ ]]; then
                            # copy all contents to directory to be symlinked without overwriting existing files
                            rsync -r --ignore-existing "$symlink_path" "$DOTFILES_ROOT"
                            # remove old directory after merge
                            rm -r "$symlink_path"
                            # symlink directory with files and directories from the original folder merged in
                            ln -s --no-target-directory "$file" "$symlink_path"
                        else
                            continue
                        fi
                    else
                        ln -s --no-target-directory "$file" "$symlink_path"
                    fi
                fi

                info_nl "Symlinked $symlink_path -> $file"
            done
        fi
    fi
fi


# Cleanup
rm -r "$GENERATED_HOOKS"

if (( found_issues )) && (( dry_run )); then
    exit 1
else
    exit 0
fi
