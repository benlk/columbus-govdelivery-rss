#! /usr/bin/env bash
set -euo pipefail
bash ./scraper.bash

# Append new lines to feeds.csv
bash ./parser.bash >> feeds.csv

# Remove duplicate lines from feeds.csv
uniq -u feeds.csv > feeds.tmp && mv feeds.tmp feeds.csv

php subscriptions.opml.php > subscriptions.opml
git status
