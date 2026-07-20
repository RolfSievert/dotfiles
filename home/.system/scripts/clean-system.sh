#!/usr/bin/env bash

# TODO:
# - add dry run flag?

if command -v yay >/dev/null 2>&1; then
    pkg_man="yay"
    sudo_pkg_man="yay"
elif command -v pacman >/dev/null 2>&1; then
    pkg_man="pacman"
    sudo_pkg_man="sudo pacman"
    sudo true
else
    echo "Error: Neither yay nor pacman is installed."
    exit 1
fi

echo "Using package manager: $pkg_man"

free_space() {
    df --output=avail -B1 / | awk 'NR==2 {print $4}'
}

# Size of package including dependencies not used by other packages
package_size() {
    $pkg_man -Rs --print-format '%s' "$1" | awk '{size+=$1} END {print size/1048576}'
}
sum_package_sizes() {
    SIZE=0
    for var in "$@"; do
        SIZE=$SIZE+$(package_size "$var")
    done
    echo "$SIZE"
}

space_before=$(free_space)

if ! [ -z "$($pkg_man -Qtdq)" ]; then
    # -n flag: do not save important configuration files
    echo Removing unused orphans...
    $sudo_pkg_man -Rns "$($pkg_man -Qtdq)"
fi

# Clear journal
echo Removing old logs...
sudo journalctl --vacuum-time=7d

# TODO? Remove broken symlinks, can be dangerous

# Stores result in $REPLY
read -p "Do you want to remove uninstalled cached packages? " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
    # Remove not installed cached packages
    # The extra 'c' ensures nothing is left in cache
    $sudo_pkg_man -Scc
fi

# Remove cashed packages except the most recent ones
# removal candidates: paccache -dk1
read -p "Do you want to remove cached packages (except the latest versions)? " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
    sudo paccache -rk1
fi
paccache -dk1

CACHE_SPACE=$(sudo du -sh ~/.cache/)
echo ~/.cache/ occupies "$CACHE_SPACE"
read -p "Do you wish to clean cache? " -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
    # Remove not installed cashed packages
    echo "Do it yourself!!"
    echo " - sudo rm -rf ~/.cache/"
fi

space_after=$(free_space)
freed_space_gb=$(( (space_after - space_before) / 1024 / 1024 / 1024 ))

echo
echo "Freed $freed_space_gb GiB"
