#! /bin/sh

#TODO add support for python scripts, etc.
#TODO print in colors

# $1 is script name
# Find program named $1 ending with .cpp in or below current folder
# Should accept --strict flag, which aborts whenever a wrong answer is given

# compile program with g++

# search for *.{ans/out}-files and their corresponding *.in-files containing program name

# Run through test files and output result of each one

# A failed result prints the output of the entire failed test and shows comparison to correct answer,
# and stops the testing

# with --strict flag enabled, don't print output after the first false one (easier to debug)
