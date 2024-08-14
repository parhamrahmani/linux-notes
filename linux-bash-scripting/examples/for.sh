# Shebang line

#!/usr/bin/env bash

# Variables

NAMES=$@

# Main

for NAME in $NAMES

do
    if [ $NAME = "Parham" ]
    then
        echo "Parham is the main User! Hello Parham! We are looking for John!"
        continue
    elif [ $NAME = "John" ]
    then
	echo "John Found! Finish the Loop!"
	break 	        
    fi
    echo "Hello $NAME, You are not John thoguh!"
    
done

echo "for loop finished"

# Exit mode

exit 0
