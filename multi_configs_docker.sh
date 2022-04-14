#!/bin/bash

# open .env file change for test env

env_file=/home/zivile/PorAmaisB/skaphos/.env

sed -i "s/^DATALAKE_PATH\=test\/fixtures/\#DATALAKE_PATH\=test\/fixtures/" $env_file
sed -i "s/^ENV\=test/\#ENV\=test\nENV=production/" $env_file
cat $env_file &
BACK_PID=$!
wait BACK_PID

echo 
declare -a areas=(bio qui fis cna lpt mat)
declare -a entities=(regionals schools state)

# run configs
for area in "${areas[@]}"; do
	for entity in "${entities[@]}"; do
		docker-compose run -v /home/zivile/s3/foco-datalake:/s3 -e DATALAKE_PATH=/s3/ skaphos pipenv run luigi --module skaphos.jobs.raw_to_stacked RawToStacked --config-path skaphos/config/raw/es_2021_tri1_participation_rates_"$entity"_"$area".yml --local-scheduler &
		BACK_PID=$!
		wait $BACK_PID
	done
done

echo
# open .env and change back

sed -i "s/^\#DATALAKE_PATH\=test\/fixtures/DATALAKE_PATH\=test\/fixtures/" $env_file
sed -i "s/\#ENV\=test/ENV\=test/" $env_file
sed -i "/ENV\=production/d" $env_file
echo -n "" 
cat $env_file


