#!/bin/bash 
# 01/06/2020 my first shell script creation. 
# It is intended as terminal startup script to lighten the mood and motivate a bit ;).
# Displays a greeting depending on time of the day, motivational wording, date set up in lithuanian language and home dir listing sorted by the last modified files.
# Requires:
# lithuanian language generated and present in locale -a listing
# figlet and lolcat programs for a  text formatting and coloring.

LC_TIME_old=$LC_TIME			# save the current set up
export LC_TIME=lt_LT.utf8		# set up a new language for time.
start_hour=$(date +'%H')		# CURRENT hour
current_time=$(date +'%A %F %H:%M')
blue='\033[1;34m'
red='\033[1;31m'
#back_normal='\e[0m'

# lt_LT.UTF-8 is found in /usr/share/i18n/SUPPORTED 
# $ cat /etc/locale.gen  to look for a specific language, then generate it $ sudo locale-gen lt_LT.UTF-8, and look for it in $ locale -a.

body () {

		 printf "$red There is no reasonable excuse for DOING anything less than your BEST.\n\n"
		printf "\t\t$blue%s\033[0m\n" "$current_time"
		ls -ltc $HOME
}

case $start_hour in
		[6-9] |10|11)	# for learning purpose shell pattern (pattern matching) is this way. Can not be used range within [0-24], only range [0-9].
				echo "Good morning Sunshine!" | figlet | lolcat
							# figlet is a program for message in fun format.
				body
				;;
			1[2-7])
				echo "Sveika $LOGNAME!" | figlet | lolcat
				body
				;;
	[1-2][890123])
				echo "Keep on going!" | figlet | lolcat
				body
				;;
			[0-5])
				echo "Exciting night!" | figlet | lolcat
				body	
				;;
esac
		
export LC_TIME=$LC_TIME_old		# return back to usual language set up.

#Execute script -- from the ~/.bashrc file with sh command

