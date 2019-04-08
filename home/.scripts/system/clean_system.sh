#!/bin/sh
echo Removing unused orphans...
if ! [ -z "$(pakku -Qtdq)"]; then
    pakku -Rns $(pakku -Qtdq)
    echo Done.
else 
    echo No unused orphans exist.
fi

# Remove cached packages
echo Do you want to remove cached packages? This will make installment of packages offline impossible.
pakku -Sc
