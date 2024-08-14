# Shebang line

#!/usr/bin/env bash

# Variables

USER_NAME=$1
USER_AGES=$2

# Main

if [ $USER_NAME = Parham ]
then
    echo Welcome Parham !
elif [ $USER_NAME = John ]
then
    echo Welcome John !
else
     echo You are not Parham or John!
fi

if [ $USER_AGES -gt 18 ]
then
    echo You are an adult !
elif [ $USER_AGES -lt 18 ]
then
    echo You are not an adult !
else
    echo You are 18 ! Congrats !
fi

# Exit code

exit 0
