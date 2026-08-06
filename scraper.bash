#!/bin/bash

set -euo pipefail

CSV_FILE="./feeds.csv"
RSS_DIR="./rss"

mkdir -p "$RSS_DIR"

if [[ ! -f "$CSV_FILE" ]]; then
	echo "Error: $CSV_FILE not found"
	exit 1
fi

# Read feed numbers from the first CSV column, sorted numerically and deduplicated.
mapfile -t feed_nums < <(
	awk -F',' 'NR>1 {
		gsub(/"/, "", $1)
		if ($1 ~ /^[0-9]+$/) print $1
	}' "$CSV_FILE" | sort -n -u
)

if [[ ${#feed_nums[@]} -eq 0 ]]; then
	echo "Error: no numeric feed numbers found in $CSV_FILE"
	exit 1
fi

highest_num="${feed_nums[-1]}"

# Build a fast lookup set of known numbers.
declare -A known=()
for n in "${feed_nums[@]}"; do
	known["$n"]=1
done

# Targets are missing numbers from max(1, highest-100)..highest,
# plus highest+1..highest+50.
targets=()
lower_bound=$(( highest_num > 100 ? highest_num - 100 : 1 ))

for ((num=lower_bound; num<=highest_num; num++)); do
	if [[ -z "${known[$num]:-}" ]]; then
		targets+=("$num")
	fi
done

for ((num=highest_num + 1; num<=highest_num + 50; num++)); do
	targets+=("$num")
done

echo "Found ${#feed_nums[@]} known feed numbers in $CSV_FILE"
echo "Highest feed number: $highest_num"
echo "Will scrape ${#targets[@]} feed(s)"

for num in "${targets[@]}"; do
	url="https://public.govdelivery.com/topics/OHCCC_${num}/feed.rss"
	file="${RSS_DIR}/OHCCC_${num}.rss"
	echo "$url"
	if curl -sS --create-dirs --fail "$url" --output "$file"; then
		:
	fi
	sleep 1
done
