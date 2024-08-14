#!/usr/bin/env bash

# Variables

COUNT=1

# Main

while IFS='' read -r LINE
do
	echo "LINE $COUNT: $LINE"
	if [ $COUNT -ge 3 ]
	then 
		break 
	fi
	((COUNT++))
done <"$1"

exit 0



