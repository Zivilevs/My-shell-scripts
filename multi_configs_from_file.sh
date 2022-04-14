#!/bin/bash

read -p "Please enter the path for config list file: " fpath

FILE=$fpath

until [ -f "$FILE" ]; do
    read -p "$FILE path does not exist. Please enter filepath: " fpath
    FILE=$fpath
done
echo "$FILE exists.i"
echo "Initiating the job..."


while IFS= read -r line; do
        echo "Config $line is submitted"
	    SKAPHOS_ENV=ECS skaphos RawToStacked --config-path skaphos/config/raw/"$line" &
		BACK_PID=$!
		wait $BACK_PID
        sleep 1m
done < "$FILE"

echo "JOB COMPLETED"
