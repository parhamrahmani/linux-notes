#!/usr/bin/env bash

# Variables

COMPUTER=34
OVER=0

# Main

while [ $OVER -eq 0 ]
do
	read -p "Please guess a number between 1 to 50!" NUM
	# avoid empty input
	if [[ ( -z $NUM ) ]]
	then 
		echo "No param passed"
		continue
	
	# using regular expression so we only accept digits 0-9
	elif [[ ! $NUM =~ ^[0-9]+$ ]]
	then
		echo "Non-digit characters detected [$NUM]"
		continue
	elif [ $NUM -lt $COMPUTER ]
	then 
		echo "your guess is lower than expected"
		continue
	elif [ $NUM -gt $COMPUTER ]
	then
		echo "Your guess is higher than expected"
		continue
	else
		echo "Your guess is right! [$COMPUTER]"
	fi
	OVER=1
	
done

echo "Game Over"

exit 0 


