#!/bin/bash

# https://stackoverflow.com/a/24967128

set -u

for num in {500..699}; do
	# build URL and try to download
	URL="https://public.govdelivery.com/topics/OHCCC_$num/feed.rss"
	FILE="./rss/OHCCC_$num.rss"
	echo $URL
	CURL=$(curl -sS --create-dirs --fail "$URL" --output "$FILE" )
	sleep 1

done
