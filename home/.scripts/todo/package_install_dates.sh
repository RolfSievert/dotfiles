#! /bin/sh
#
# package_install_dates.sh
# Copyright (C) 2020 rolfsievert <rolfsievert@manjaro>
#
# Distributed under terms of the MIT license.
#


cat /var/log/pacman.log | grep "\-S --config" | grep -v "community" | grep -v "extra" | grep -v "extra" | grep -o "[^ ]\+$"
