#!/bin/sh
echo Removing unused orphans...
if ! [ -z "$(pakku -Qtdq)"]; then
    pakku -Rns $(pakku -Qtdq)
else 
    echo No unused orphans exist.
fi
