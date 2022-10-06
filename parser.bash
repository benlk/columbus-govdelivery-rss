#!/bin/bash

echo '"Feed Number","Title","Link","Description","Feed URL","Newsletter Signup URL","Most-Recent Date","Number of items"'

for file in ./rss/*.rss
do
	# These are already double-quoted
	TITLE=$(cat $file | xq .rss.channel.title )
	LINK=$(cat $file | xq .rss.channel.link )
	DESCRIPTION=$(cat $file | xq .rss.channel.description )
	RECENT=$(cat $file | xq '.rss.channel.item[0].pubDate' )
	COUNT=$(cat $file | xq '.rss.channel.item | keys | length' )

	NUMBER=$( echo $file | sed -r 's%./rss/OHCCC_([[:alnum:]]+)\.rss%\1%')

	FEEDURL="https://public.govdelivery.com/topics/OHCCC_$NUMBER/feed.rss"
	SIGNUP="https://public.govdelivery.com/accounts/OHCCC/subscriber/new?qsp=OHCCC_$NUMBER"

	CSV_LINE="\"$NUMBER\",$TITLE,$LINK,$DESCRIPTION,\"$FEEDURL\",$SIGNUP,$RECENT,$COUNT"
	echo $CSV_LINE
done
