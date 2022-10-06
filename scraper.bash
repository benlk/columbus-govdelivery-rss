#!/bin/bash

# https://stackoverflow.com/a/24967128

for num in {1..999}; do
	# build URL and try to download
	URL="https://public.govdelivery.com/topics/OHCCC_$num/feed.rss"
	FILE="./rss/OHCCC_$num.rss"
	echo $URL
	CURL=$(curl -sS --create-dirs --fail "$URL" --output "$FILE" )
	sleep 10

done
