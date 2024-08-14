
# Shebang line

#!/usr/bin/env bash

# Variables

COUNT=1

# Main

while [ $COUNT -le 10 ]
do 
   echo "COUNT= $COUNT"
   ((COUNT++))
done

echo "While loop has finished"   

# Exit code

exit 0
