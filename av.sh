#!/bin/sh

#Somnio Audio/Video playback script

#Launches new window with media playing if video

#Plays in new term if music

if [ -z $isAudio ];
	then
	mplayer "$filesSelected" > /dev/null 2>&1
else
	xterm -e /usr/bin/mplayer "$filesSelected"
fi

exit
