#! /bin/sh

echo ERRORS IN LOGFILES:
journalctl -p 3 -xb

echo Searching for broken symlinks
find / -xtype l -print
echo Broken symlinks listed above
