#! /usr/bin/env bash
set -euo pipefail
bash ./scraper.bash
bash ./parser.bash > feeds.csv
php subscriptions.opml.php > subscriptions.opml
git status
