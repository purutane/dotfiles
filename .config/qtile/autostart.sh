#!/bin/sh
picom &
fcitx5 &
nm-applet &
blueman-applet &
1password --silent &
dropbox &

# set external display as primary
dp3stat=$(xrandr | grep "DP-3" | awk '{print $2}')
if [ $dp3stat = 'connected' ]
then
    xrandr --output eDP-1 --mode 2160x1350 --pos 0x0 --rotate normal --output DP-3 --primary --mode 3840x1600 --pos 2160x0 --rotate normal
    xwallpaper --output DP-3 --stretch ${HOME}/wallpaper/arch-3840x1600.png
fi
xwallpaper --output eDP-1 --stretch ${HOME}/wallpaper/arch-2160x1350.png
