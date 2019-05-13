#! /bin/sh

echo ERRORS IN LOGFILES:
journalctl -p 3 -xb
