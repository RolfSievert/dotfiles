#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar > ~/.config/polybar/launch_log.txt; do sleep 1; done

# Launch bar1 and bar2
polybar bar &

echo "Bars launched..."
