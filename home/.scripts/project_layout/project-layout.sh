#! /bin/sh
#
# fzf_folder.sh
# Copyright (C) 2019 hitsnapper <hitsnapper@Znap>
#
# Distributed under terms of the MIT license.
#
source ~/.zshrc

#Include hidden files
#OLD res=$(find ~/${1:-.} -type d 2> /dev/null | fzf +m)
res=$(find ~/ -name '.*' -prune -o -print | fzf +m)
# Exclude hidden files
/usr/bin/python $(dirname $0)/open-layout.py $res
