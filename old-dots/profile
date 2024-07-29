#!/bin/sh

# Load path config file
[ -f ~/.path ] && . ~/.path

# Load tokens
[ -f ~/.tokens ] && . ~/.tokens

[[ $- != *i* ]] && return

# Startx on login
[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x Xorg >/dev/null && exec startx

# keyboard
setxkbmap -layout us -variant intl

