#!/usr/bin/env bash

STATUS=0

if [ -z $1 ]
then
    echo "You must provide a PID"
    exit 1
fi
echo "Watching PID $1"

while [ $STATUS -eq 0 ]
do
    ps $1 > /dev/null
    STATUS=$?
    sleep 1
done

echo "Process $1 has terminated"

exit 0
