#! /bin/sh
#
# update-mirrors-by-speed.sh
#

cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup

rankmirrors -n 6 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist
