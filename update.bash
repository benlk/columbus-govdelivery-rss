#! /usr/bin/env bash
set -euo pipefail
bash ./scraper.bash

# Use git to check if there are any changes in the ./rss directory
if git diff --quiet --exit-code ./rss; then
    echo "No new feeds found. Exiting."
    exit 0;
fi

# Append new lines to feeds.csv
bash ./parser.bash >> feeds.csv

# Remove duplicate lines from feeds.csv
uniq -u feeds.csv > feeds.tmp && mv feeds.tmp feeds.csv

php subscriptions.opml.php > subscriptions.opml
git status
