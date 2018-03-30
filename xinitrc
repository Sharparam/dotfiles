dbus-update-activation-environment --systemd DISPLAY
setxkbmap -option caps:escape
xrdb -load ~/.Xresources
xrandr --dpi 168
exec i3
