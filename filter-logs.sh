#!/bin/bash

# Path to today's access log
ACCESS_LOG="/var/log/nginx/access.log"

# directory for filtered logs
FILTERED_DIR="/system-scripts/filtered-logs"

# tpoday date for output file names
TODAY=$(date +%Y-%m-%d)
MOMENTKAPH_FILE="$FILTERED_DIR/momentkaph-$TODAY.log"
SUCCESS_FILE="$FILTERED_DIR/success-$TODAY.log"

# filter lines containing "momentkaph.sk"
grep "momentkaph.sk" "$ACCESS_LOG" > "$MOMENTKAPH_FILE"

# filter lines with 200 response code
awk '$9 == "200"' "ACCESS_LOG" > "$SUCCESS_FILE"

# set proper permissions
chmod 644 "$MOMENTKAPH_FILE" "$SUCCESS_FILE"



