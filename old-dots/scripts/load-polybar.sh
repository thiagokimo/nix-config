#! /bin/bash

killall -q polybar

while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

for m in $(polybar --list-monitors | cut -d":" -f1); do
  MONITOR=$m polybar --reload example 2>%1 | tee -a /tmp/polybar.log & disown &
done

# polybar example 2>%1 | tee -a /tmp/polybar.log & disown

echo "Polybar launched..."
