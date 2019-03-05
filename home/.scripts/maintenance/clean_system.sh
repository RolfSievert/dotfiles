#!/bin/sh
echo Removing unused orphans...
if ! [ -z "$(pakku -Qtdq)"]; then
    pakku -Rns $(pakku -Qtdq)
    echo Done.
else 
    echo No unused orphans exist.
fi
