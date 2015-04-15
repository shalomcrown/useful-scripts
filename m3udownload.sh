#!/bin/bash
###############################################################
# Download all files from m3u
# For sites like http://www.liberliber.it/musica m3u files
# are provided to show all tracks in an album. If you want to 
# download the entire album, you can use this file. This script
# utilizes the file to download all ths tracks.
#
# Input parameter: m3u file's URL
#
###############################################################

clr_blue="\033[0;34m"
clr_green="\033[0;32m"
clr_red="\033[0;31m"
clr_end="\033[0m"

if [[ -z $1 ]] 
then
	echo -e $clr_red 'Please supply a URL of an M3U file' $clr_end
	exit -1
fi

M3U_URL=$1
M3U_FILE=$(basename $1)
M3U_BASE=$(dirname $1)

echo -e "${clr_green}Download M3U file ${M3U_FILE}${clr_end}"
wget $1 || exit $?

tr -d '\r' < ${M3U_FILE} > ${M3U_FILE}.unx 

while read i 
do
	[[ $i == '#'* ]] && continue 

	echo -e "${clr_green}Download Music file ${i}${clr_end}"

	MUSIC_URL=${M3U_BASE}/${i}

	wget ${MUSIC_URL}

done < ${M3U_FILE}.unx


