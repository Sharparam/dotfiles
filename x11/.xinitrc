dbus-update-activation-environment --systemd DISPLAY
setxkbmap -option caps:escape
xrdb -load ~/.Xresources
xrandr --dpi 168
xinput disable "SynPS/2 Synaptics TouchPad"
exec i3
