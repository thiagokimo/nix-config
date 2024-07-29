#! /bin/sh

if [[ $(xrandr -q | grep "HDMI-1 connected") ]]; then
  echo "HDMI-1 connected. Selecting home monitor setup..."
  sh $SCREENLAYOUT_HOME/wide-and-laptop.sh
  bspc monitor eDP-1 -d I II III IV V
  bspc monitor HDMI-1 -d VI VII VIII IX X
elif [[ $(xrandr -q | grep -wv "eDP-1 connected" | grep "DP-1 connected") ]]; then
  echo "Display port connected. Selecting office monitor setup..."
  sh $SCREENLAYOUT_HOME/office.sh
  bspc monitor eDP-1 -d I II III IV V
  bspc monitor DP-1 -d VI VII VIII IX X
else
  "No external monitors are connected. Selecting laptop-only monitor setup..."
  sh $SCREENLAYOUT_HOME/laptop-only.sh
  bspc monitor eDP-1 -d I II III IV V VI VII VIII IX X
fi

