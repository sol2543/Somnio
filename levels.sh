#!/bin/bash

#Script to decrease audio and brightness levels, and start any selected visualization


echo "Selected timer length is: $timerLength minutes"

i="0"

divValue=$(($timerLength/10))

export divValue
export timerLength

#echo "The divValue is: $divValue"

if [[ $visChoice == *None* ]] || [[ $visPos == 0 ]];
#if [[ $visChoice == *None* ]]
	then

	while [ $i -lt $timerLength ] 

		do
		#while for while sound less than 0 or something?
		amixer set Master 5%- > /dev/null 2>&1
		#while for while backlight less than 0 or something?
		xbacklight -2
		sleep "$divValue"m
		let "i=i+1"
		done
else
	python sierpinski_triangle_display.py &
	while [ $i -lt $timerLength ] 

	        do
	        #while for while sound less than 0 or something?
        	amixer set Master 5%- > /dev/null 2>&1
       		#while for while backlight less than 0 or something?
        	xbacklight -2
        	sleep "$divValue"m
        	let "i=i+1"
        	done
fi

exit

