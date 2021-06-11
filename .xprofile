#!/usr/bin/env sh

dpi=$(xrandr |grep -w "connected.*x"| head -n1| sed -E 's|.*x([0-9]+)\+.* ([0-9]+)mm$|scale=0;(\1*25.4/\2)|'|bc)
nice_dpi=$(echo "scale=0;$dpi/16*16"|bc)
printf "Xft.dpi: $nice_dpi;\n*dpi: $nice_dpi"|xrdb -merge
# xrandr --dpi $nice_dpi

# xsettings_dpi=$(printf "%i *1024" $nice_dpi|bc)
# printf 'Xft/Antialias 1 \n Xft/HintStyle "hintfull"\n Xft/Hinting 1 Xft/RGBA "none"\n Xft/DPI  %i' $xsettings_dpi > ~/.xsettingsd

#Set the QT scale by hand
# export QT_AUTO_SCREEN_SCALE_FACTOR=0
# export QT_SCALE_FACTOR=1


export PATH=$HOME/.local/bin/:$PATH

#Apps
export BROWSER=firefox
export TERMCMD="kitty"
export TERMINAL=$TERMCMD

