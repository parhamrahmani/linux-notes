# Sherbang line

#!/usr/bin/env bash

# Variables

USER_NAME=$1
FAVORITE_SPORT=$2
DATE=$(date)
WORKING_DIRECTORY=$(pwd)

# Main

echo Working directory : $WORKING_DIRECTORY Time : $DATE
echo The name of the script : $0
echo Hello $USER_NAME ! Your favorite sport is $FAVORITE_SPORT !

# Exit code

exit 100
