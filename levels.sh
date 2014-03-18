#!/bin/bash

#script to decrease audio and brightness levels


#decrease audio levels

echo "Selected timer length was: $timerLength"

i="0"

divValue=$(($timerLength/10))

echo "The divValue is: $divValue"

while [ $i -lt $timerLength ] 

	do
	#while for while sound less than 0 or something?
	amixer set Master 5%-
	#while for while backlight less than 0 or something?
	xbacklight -2
#	i=$[$i+$divValue]
	sleep "$divValue"m
	let "i=i+1"
	echo $i
	done

echo "the divValue is: $divValue"

#for i in {0..$timerLength..$divValue}
#	do
#	amixer set Master 5%-
#	xbacklight -10
#	sleep "$divValue"m
#	done

