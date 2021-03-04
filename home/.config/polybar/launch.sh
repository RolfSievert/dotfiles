#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar > ~/.config/polybar/launch_log.txt; do sleep 1; done

# Launch bar1 and bar2
echo "---" | tee -a /tmp/polybar.log
polybar bar 2>&1 | tee -a /tmp/polybar.log & disown

echo "Bars launched..."
