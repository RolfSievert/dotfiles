#! /bin/sh
#
# fzf_folder.sh
# Copyright (C) 2019 hitsnapper <hitsnapper@Znap>
#
# Distributed under terms of the MIT license.
#

res=$(find ~/${1:-.} -type d 2> /dev/null | fzf +m)
python $(dirname $0)/open-layout.py $res
