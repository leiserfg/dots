#!/bin/bash

run_once () {
    pidof "$(basename $1)" || run_disowned "$@"
}

run_disowned () {
    nohup "$@" > /dev/null 2>&1 &
}


xset -b
pkill -9 picom; picom -b

run_once ~/.nix-profile/libexec/polkit-gnome-authentication-agent-1

