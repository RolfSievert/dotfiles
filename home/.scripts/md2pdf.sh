#!/bin/bash

    #--include-in-header chapter_break.tex \
    #-V fontsize=30pt \
    #    --listings \
    #    -f gfm \
    #--pdf-engine=xelatex \

pandoc "$1" \
    -V interlinespace:8ex \
    -V linkcolor:blue \
    -V geometry:a4paper \
    -V geometry:margin=2cm \
    -V mainfont="Liberation Sans" \
    -V monofont="Noto Sans Mono" \
    --highlight-style pygments \
    --listings \
    --pdf-engine=xelatex \
    -o "$2"
