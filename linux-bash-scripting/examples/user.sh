#!/usr/bin/env bash

VALID=0

while [ $VALID -eq 0 ]
do
	read -p "Please enter your name and age: " NAME AGE
	# avoid empty inputs
	if [[ ( -z $NAME ) || ( -z $AGE ) ]]
	then
		echo "Not enough params passed"
		continue
	# using regular expression > so in name the value must be alphabetic
	
	elif [[ ! $NAME =~ ^[A-Za-z]+$ ]]
	then
		echo "Non alpha characters detected [$NAME]"
		continue
	# using regular expressions > so in age it must be digits form 0 to 9
	elif [[ ! $AGE =~ ^[0-9]+$ ]]	
	then
		echo "Non-digit characters detected [$AGE]"
		continue
	fi
	VALID=1
		
done
echo "Name = $NAME and Age = $AGE"
exit 0
