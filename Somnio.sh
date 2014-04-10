#!/bin/sh

# Somnio (Latin for "dream,") A Linux media sleep timer.

zenity --info --title="Somnio" --text="Welcome to Somnio, the media sleep timer! Please continue and select the type of media you wish to play... \n\nSomnio will then ask for the amount of time you wish it to run, play the selected media then quit." --height=25 --width=250 --no-wrap

#Select Media Type

mediaType=$(zenity --list --title="Select Media Type" --column=Media Audio Video "Internet Radio")

echo $mediaType "was selected"


if [ "$mediaType" = "Internet Radio" ];
	then
	zenity --question --title="Stations Available" --text="Would you like to see a list of available internet radio stations?"
	
	if [ $? -eq 0 ];
		then
		zenity --info --title="Stations Available" --text="List of internet radio stations: \n \n 1. www.internet-radio.com/ \n 2. www.netradiolist.com/ \n 3. http://www.listenlive.eu/uk.html"
	else
		:
	fi
	
	else
		:
fi
	

#If Audio or Video go to file selection screen, if internet radio stream go to stream address input

while [ -z "$filesSelected" ];
	do

	if [ "$mediaType" = "Audio" ]; 
		then
		filesSelected=$(zenity --file-selection)
		isAudio=1
	elif [ "$mediaType" = "Video" ]; 
		then
		filesSelected=$(zenity --file-selection)
	else
		filesSelected=$(zenity --entry --text="Enter the radio stream's address: ")
		radioaddy=$filesSelected
	fi
done


numCheck='^[0-9]+$'
#implement function to check if number 0-999 is entered

timerLength=$(zenity --entry --text="Enter the desired sleep timer length in minutes in numeric format (ex: 45): ");

export isAudio
export radioaddy
export filesSelected
export timerLength
#echo $radioaddy
#echo $filesSelected

if [ -z $radioaddy ];
	then
	echo "Audio/Video files selected:"
	echo $filesSelected
	#a/v script
	./av.sh & python nowplaying.py & ./levels.sh & sleep "$timerLength"m
else
	echo "Internet radio selected for playback"
	echo $radioaddy 
	#radioscript
	./radio.sh & python nowplaying.py & ./levels.sh & sleep "$timerLength"m
fi


#call script to decrement brightness and audio levels
#./levels.sh


#sleep "$timerLength"m

# zenity --info --title="Quitting..." --text="Application will quit in 1 minute..."

exit

