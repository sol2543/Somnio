#!/bin/sh

# Somnio (Latin for "dream,") A Linux media sleep timer.

zenity --info --title="Somnio" --text="Welcome to Somnio, the media sleep timer! Please continue and select the type of media you wish to play... \n\nSomnio will then ask for the amount of time you wish it to run, play the selected media then quit." --height=25 --width=250 --no-wrap

#Select Media Type

mediaType=$(zenity --list --title="Select Media Type" --column=Media Audio Video "Internet Radio")

echo $mediaType "was selected"

#If Audio or Video go to file selection screen, if internet radio stream go to stream address input

while [ -z "$filesSelected" ];
	
	 do

	if [ $mediaType = "Audio" ]; then
		filesSelected=$(zenity --file-selection);
	elif [ $mediaType = "Video" ]; then
		filesSelected=$(zenity --file-selection);
	else
		filesSelected=$(zenity --entry --text="Enter the radio stream's address: ");
	fi
done

numCheck='^[0-9]+$'
#implement function to check if number 0-999 is entered

timerLength=$(zenity --entry --text="Enter the desired sleep timer length in minutes in numeric format (ex: 45): ");


#call script to decrement brightness and audio levels
export timerLength
./levels.sh

#play back selected media

# python pytest1.py

sleep "$timerLength"m

# zenity --info --title="Quitting..." --text="Application will quit in 1 minute..."


exit

