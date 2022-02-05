#!/bin/bash

run_once () {
    pidof "$(basename $1)" || run_disowned "$@"
}

run_disowned () {
    nohup "$@" > /dev/null 2>&1 &
}


xset -b
pkill -9 picom; picom -b

nitrogen --restore

xset s 300 600
run_once xsettingsd
run_once light-locker --lock-on-lid
run_once /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
run_once nm-applet
run_once unclutter -b #hide the cursor when not moving it


