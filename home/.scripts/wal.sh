#!/bin/sh

#I=~/Pictures/5vvyo4u8y8wz.jpg # image (w h ratio = 1.78)
S=0.35 # saturation

wal -i $1 --saturate $S --backend haishoku

# Backends:
# colorz, schemer2, haishoku, colorthief, wal
