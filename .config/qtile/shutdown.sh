#!/bin/bash

res=$(echo "lock;reload;restart;suspend;shutdown" | rofi -sep ";" -dmenu -p "power:" -bw 0 -bc "#f3f4f5" -bg "#f3f4f5" -fg "#2f343f" -hlbg "#2f343f" -hlfg "#f3f4f5" -separator-style none -location 0 -width 250 -hide-scrollbar -padding 30)

if [ $res = "suspend" ]; then
    systemctl suspend
fi

if [ $res = "lock" ]; then
    dm-tool lock
fi
if [ $res = "restart" ]; then
    systemctl reboot
fi
if [ $res = "shutdown" ]; then
    systemctl poweroff
fi
exit 0
