#! /bin/sh

echo ERRORS IN LOGFILES:
journalctl -p 3 -xb

echo Searching for broken symlinks
find / -xtype l -print
echo Broken symlinks listed above

echo Having problem with sudo? Check: https://askubuntu.com/questions/248853/graphical-authentication-works-why-does-sudo-say-my-password-is-wrong
