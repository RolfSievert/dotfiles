#! /bin/sh

# Given input, search for a folder that matches pattern
find ${1:-.} -type d 2> /dev/null | fzf +m
