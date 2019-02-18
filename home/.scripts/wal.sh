#!/bin/sh

# image (w h ratio = 1.78)
S=0.35 # saturation
B=1 # backend index

# Backends: colorz, schemer2, haishoku, colorthief, wal
backend=(wal colorthief haishoku colorz schemer2)

if ! [ -z "$2" ]; then
    B=$2
fi

if ! [ -z "$3" ]; then
    S=$3
fi

wal -i $1 --saturate $S --backend ${backend[B]}

