#!/bin/sh

# Somnio (Latin for "dream,") A Linux media sleep timer.

zenity --info  --title="Somnio" --text="Welcome to Somnio, the media sleep timer! Please continue and select the type of media you wish to play... \n\nSomnio will then ask a few other questions, play your selected media, then quit." --height=25 --width=250 --no-wrap

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
		filesSelected=$(zenity --file-selection --title="Somnio")
		isAudio=1
		visPos=1
	elif [ "$mediaType" = "Video" ]; 
		then
		filesSelected=$(zenity --file-selection --title="Somnio")
	else
		filesSelected=$(zenity --entry --text="Enter the radio stream's address: " --title="Somnio")
		radioaddy=$filesSelected
		visPos=1
	fi
done

if [ "$visPos" = 1 ];
	then
		visChoice=$(zenity --list --title="Select visualizations" --text="Options:" --radiolist --column="" --column="Selections:" TRUE "Sierpinski Triangles Visualization" FALSE "None")
		echo "Visualization chosen:" $visChoice
	else
		:
fi

#timerLength=$(zenity --entry --text="Enter the desired sleep timer length in minutes in numeric format (ex: 45): " --title="Somnio");

timerLength=$(zenity --scale --min-value=10 --max-value=240 --value=10 --text="Enter the desired sleep timer length" --title="Somnio");

export isAudio
export radioaddy
export filesSelected
export timerLength
export visChoice

lastMinute=$(($timerLength-1))
echo $lastMinute

if [ -z $radioaddy ];
	then
	echo "Audio/Video files selected:"
	echo $filesSelected
	#a/v script
	./av.sh & python nowplaying.py & ./levels.sh & sleep "$lastMinute"m && echo "One more minute until program shutdown!" && sleep 1m && ./quit.sh
else
	echo "Internet radio selected for playback"
	echo $radioaddy 
	#radioscript
	./radio.sh & python nowplaying.py & ./levels.sh & sleep "$lastMinute"m && echo "One more minute until program shutdown!" && sleep 1m && ./quit.sh
fi

exit

