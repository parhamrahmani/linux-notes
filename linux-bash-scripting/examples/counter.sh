#!/usr/bin/env bash

# Variables
COUNTER=1
COUNTER_END=$1

# Main

echo "COUNTING FROM 1 TO $COUNTER_END"

# Parameter checks
if [ "$#" -eq 0 ]; then
    echo "No parameters are passed"
    exit 1
elif [ $COUNTER_END -lt 0 ]; then
    echo "No negative numbers are allowed"
    exit 3
elif [ $COUNTER_END -eq 0 ]; then
    echo "Zero is not allowed"
    exit 4
fi

# Counting loop
while [ $COUNTER -le $COUNTER_END ]; do
    echo "$COUNTER"
    ((COUNTER++))
done

echo "Counting finished"

# Exit code
exit 0

