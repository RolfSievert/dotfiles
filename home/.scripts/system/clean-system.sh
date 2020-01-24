#!/bin/sh
sudo true

# Size of package including dependencies not used by other packages
package_size() {
    pacman -Rs --print-format '%s' $1 | awk '{size+=$1} END {print size/1048576}'
}
sum_package_sizes() {
    SIZE=0
    for var in "$@"; do
        SIZE=$SIZE+$(package_size $var)
    done
    echo $SIZE
}

if ! [ -z "$(pacman -Qtdq)"]; then
    # -n flag: do not save important configuration files
    echo Removing unused orphans...
    sudo pacman -Rns $(pacman -Qtdq)
fi

# Clear journal
echo Removing old logs...
sudo journalctl --vacuum-time=7d

# Remove broken symlinks
BROKEN_SYMLINKS=$(sudo find '/' -type d \( -path '/proc' -o -path '/run' \) -prune -o -xtype l)

if [[ -z "${BROKEN_SYMLINKS// }" ]]; then
    printf '%s\n' "${BROKEN_SYMLINKS[@]}"

    SYMSIZE=`sudo du -sm ${BROKEN_SYMLINKS[@]}`
    read -p "Do you want to remove the broken symlinks listed above? ($SYMSIZE) " -r
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        sudo rm -f ${BROKEN_SYMLINKS[@]}
    fi
fi

# Stores result in $REPLY
read -p "Do you want to remove uninstalled cached packages? " -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
    # Remove not installed cached packages
    # The extra 'c' ensures nothing is left in cache
    sudo pacman -Scc
fi

# Remove cashed packages except the most recent ones
# removal candidates: paccache -dk1
read -p "Do you want to remove cached packages (except the latest versions)? " -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
    sudo paccache -rk1
fi
paccache -dk1
CACHE_SPACE=`sudo du -sh ~/.cache/`
echo ~/.cache/ occupies $CACHE_SPACE
read -p "Do you wish to clean cache? " -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
    # Remove not installed cashed packages
    sudo rm -rf ~/.cache/
fi
