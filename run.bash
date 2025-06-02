#! /usr/bin/env bash
#
# This script wraps up the update process in a simple script.
bash ./scraper.bash
bash ./parser.bash > feeds.csv
php subscriptions.opml.php > subscriptions.opml
git diff
