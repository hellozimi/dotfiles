#!/usr/bin/env sh

killall -q polybar

while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

MONITOR=DP-0 polybar --reload main -c $HOME/.config/polybar/config.ini & >/dev/null
MONITOR=HDMI-0 polybar --reload second -c $HOME/.config/polybar/config.ini & >/dev/null
