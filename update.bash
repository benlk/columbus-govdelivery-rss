#! /usr/bin/env bash
set -euo pipefail
#bash ./scraper.bash

# Use git to check if there are any changes in the ./rss directory
#if test -z "$(git ls-files --others ./rss)"; then
#    echo "No new feeds found. Exiting."
#    exit 0;
#fi

# Append new lines to feeds.csv
bash ./parser.bash >> feeds.csv

# Remove duplicate lines from feeds.csv
HEADER='"Feed Number","Title","Link","Description","Feed URL","Newsletter Signup URL"'
(printf '%s\n' "$HEADER" && awk -v header="$HEADER" '$0 != header' feeds.csv | sort -u) > feeds.tmp && mv feeds.tmp feeds.csv

php subscriptions.opml.php > subscriptions.opml
git status
