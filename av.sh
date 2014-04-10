#!/bin/sh

#Somnio Audio/Video playback script

#Launches new window with media playing if video

#Plays in background if music

if [ -z $isAudio ];
	then
	mplayer -playlist "$filesSelected"
else

	xterm -e mplayer "$filesSelected"
fi

exit
