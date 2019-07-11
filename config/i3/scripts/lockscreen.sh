#!/bin/bash

FILEPATH="/tmp/screen.png"
FILEPATH_LOCK="/tmp/lockscreen.png"
IS_i3_RUNNING=false
IS_SWAY_RUNNING=false

#Check if i3 or sway are running
if [ $(ps -ef | grep i3 | grep -v grep | wc -l) -gt 1 ]; then
	IS_i3_RUNNING=true
elif [ $(ps -ef | grep sway | grep -v grep | wc -l) -gt 1 ]; then
	IS_SWAY_RUNNING=true
else
	>&2 echo "Could not find i3 or sway running on the system"
fi

#retrieve screenshot
if $IS_i3_RUNNING; then
	import -window root $FILEPATH
elif $IS_SWAY_RUNNING; then
	grim -t png $FILEPATH
fi

if [ -z $XDG_CONFIG_HOME ]; then
	XDG_CONFIG_HOME=$HOME/.config
fi

time $XDG_CONFIG_HOME/i3/scripts/fourier.py $FILEPATH $FILEPATH_LOCK

#mute all audio
amixer -q sset Master,0 mute

#lock the screen
if $IS_i3_RUNNING; then
	i3lock --image=$FILEPATH_LOCK
elif $IS_SWAY_RUNNING; then
	swaylock --tiling --image $FILEPATH_LOCK
fi

rm $FILEPATH
