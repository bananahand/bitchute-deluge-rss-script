#!/bin/bash

## START CONFIG

channel="channelname"
deluge_host="127.0.0.1"
deluge_port="58846"
download_path="/your/download/path/"

## END CONFIG

deluge_console=$(which deluge-console)
pull_guid=$(curl -s https://www.bitchute.com/feeds/rss/channel/$channel/ | grep -Eo "<guid>.{12}" | sed "s/<guid>//g")

for guid in $pull_guid; do
	magnet=$(curl -s https://www.bitchute.com/video/$guid/ | grep -Eo "magnet.*\" data-toggle" | sed "s/\" data-toggle$//g")
	$deluge_console --quiet "connect $deluge_host:$deluge_port; add -p $download_path $magnet" >> /dev/null
done
