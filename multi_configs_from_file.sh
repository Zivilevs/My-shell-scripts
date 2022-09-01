#!/bin/bash

read -p "Please enter the relative path for config list file: " fpath

FILE=$fpath

read -p "How many minutes to wait between next job request?" twait

until [ -f "$FILE" ]; do
    read -p "$FILE path does not exist. Please enter filepath: " fpath
    FILE=$fpath
done
echo "$FILE exists."

echo "Initiating the job..."

while IFS= read -r line; do
        echo "Config $line is submitted"
	    SKAPHOS_ENV=ECS skaphos RawToStacked --config-path "$line" &
		BACK_PID=$!
		wait $BACK_PID
        sleep "$twait"m
done < "$FILE"

echo "JOB COMPLETED"
