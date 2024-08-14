# Linux Shell Scripting -Part 2 

## Conditional Statements, Branching, and Looping

### If statements

the basic syntax of if statements is this
```
if [ condition ]
then
    statement
fi
```
for example if we want to check if the user is root or not we can write this
```
if [ $USER = root ]
then
    echo Welcome root user !
fi
```
- $USER is a special variable that holds the name of the current user.

lets create a new script called if.sh
```bash
$ touch if.sh
$ chmod 755 if.sh
$ subl if.sh
```
then we write this in the script
```
# Shebang line

#!/usr/bin/env bash

# Variables

USER_NAME=$1

# Main

if [ $USER_NAME = Parham ]
then
    echo Welcome Parham !
fi


if [ $USER_NAME != Parham ]
then
     echo You are not Parham!
fi     

# Exit code

exit 0
```
then we run the script
```bash
$ ./if.sh Parham
```
and we get this output
```
Welcome Parham !
```
and also if we give it another name we get this output
```bash
$ ./if.sh John
```
```
You are not Parham!
```
We can use greater or less than ( -gt or -lt ) in if statements too. For example if we want to check if the user is root or not we can write this
```
# Shebang line

#!/usr/bin/env bash

# Variables

USER_NAME=$1
USER_AGES=$2

# Main

if [ $USER_NAME = Parham ]
then
    echo Welcome Parham !
fi

if [ $USER_NAME != Parham ]
then
     echo You are not Parham!
fi

if [ $USER_AGES -gt 18 ]
then
    echo You are an adult !
fi

if [ $USER_AGES -lt 18 ]
then
    echo You are not an adult !
fi

# Exit code

exit 0
```
then we run the script
```bash
$ ./if.sh Parham 19
```
and we get this output
```
Welcome Parham !
You are an adult !
```
or if we run this
```bash
$ ./if.sh Parham 17
```
and we get this output
```
Welcome Parham !
You are not an adult !
```
#### Else statements
the basic syntax of else statements is this
```

if [ condition ]
then
    statement
else
    statement
fi
```
for example in the last example we can write this
```
# Shebang line

#!/usr/bin/env bash

# Variables

USER_NAME=$1
USER_AGES=$2

# Main

if [ $USER_NAME = Parham ]
then
    echo Welcome Parham !
else
     echo You are not Parham!
fi

if [ $USER_AGES -gt 18 ]
then
    echo You are an adult !
else
    echo You are not an adult !
fi

# Exit code

exit 0
```
#### Elif statements

the basic syntax of elif statements is this
```
if [ condition ]
then
    statement
elif [ condition ]
then
    statement
else
    statement
fi
```

for example in the last example we can write this
```
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
```
then we run the script
```bash
$ ./if.sh Parham 18
```
and we get this output
```
Welcome Parham !
You are 18 ! Congrats !
```

#### Loops - While loops
the basic syntax of while loops is this
```
while [ condition ]
do
    statement
done
```
first we create a new script called while.sh
```bash
$ touch while.sh
$ chmod 755 while.sh
$ subl while.sh
```
for example if we want to print numbers from 1 to 10 we can write this
```
# Shebang line

#!/usr/bin/env bash

# Variables

COUNT=1

# Main

while [ $COUNT -le 10 ]
do
    echo $COUNT
    COUNT=$((COUNT + 1))
done

# Exit code

exit 0
```
- COUNT=$((COUNT + 1)) is the same as COUNT=$[$COUNT + 1] which calculates the value of COUNT + 1 and
assigns it to COUNT.

then we run the script
```bash
$ ./while.sh
```
and we get this output
```
1
2
3
4
5
6
7
8
9
10
```
we can also do this
```
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
```
- ((COUNT++)) is the same as COUNT=$((COUNT + 1)) which calculates the value of COUNT + 1 and assigns it to COUNT.
- -le means less than or equal to

then we run the script
```bash
$ ./while.sh
```
and we get this output
```
COUNT= 1
COUNT= 2
COUNT= 3
COUNT= 4
COUNT= 5
COUNT= 6
COUNT= 7
COUNT= 8
COUNT= 9
COUNT= 10
While loop has finished
```

#### Loops - For loops

the basic syntax of for loops is this
```
for variable in list
do
    statement
done
```
first we create a new script called for.sh
```bash
$ touch for.sh
$ chmod 755 for.sh
$ subl for.sh
```
In the script we write this
```
# Shebang line

#!/usr/bin/env bash

# Variables

NAMES=$@

# Main

for NAME in $NAMES
do 
	echo "Hello $NAME"
done

echo "for loop finished"

# Exit mode

exit 0	
```
- $@ is a special variable that holds all the arguments that are passed to the script.
- $@ is the same as $1 $2 $3 $4 $5 $6 $7 $8 $9 ${10} ${11} ${12} etc.
Then we run the script
```bash
$ ./for.sh Parham John
```
and we get this output
```
Hello Parham
Hello John
for loop finished
```
#### Loops - Using break and continue

##### Syntax of break
```
for variable in list
do
    statement
    if [ condition ]
    then
        break
    fi
done
```
for example in our for loop we can write this
```
# Shebang line

#!/usr/bin/env bash

# Variables

NAMES=$@

# Main

for NAME in $NAMES
do
	if [ $NAME = "Parham" ]
	then
		echo "Parham Found!"
		break
	fi 		
done

echo "for loop finished"

# Exit mode

exit 0	
```
Then we run the script
```bash
$ ./for.sh Parham John
```
and we get this output
```
Parham Found!
for loop finished
```
##### Syntax of continue
```
for variable in list
do
    statement
    if [ condition ]
    then
        continue
    fi
done
```
for example in our for loop we can write this
```
# Shebang line

#!/usr/bin/env bash

# Variables

NAMES=$@

# Main

for NAME in $NAMES

do
    if [ $NAME = "Parham" ]
    then
        echo "Parham Found!"
        continue
    fi
    echo "Hello $NAME"
done

echo "for loop finished"

# Exit mode

exit 0
```
Then we run the script
```bash
$ ./for.sh Parham John
```

and we get this output
```
Parham Found!
Hello John
for loop finished
```
###### Another Example

in our script we write this
```
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
```
Then we run the script
```bash
$ ./for.sh Parham Stacy Tracy John Ferdinand Cole
```
and we get this output
```
Parham is the main User! Hello Parham! We are looking for John!
Hello Stacy, You are not John thoguh!
Hello Tracy, You are not John thoguh!
John Found! Finish the Loop!
for loop finished
```
#### Exercise
1. Write a script called counter.sh
2. Make it executable
3. It should count from 1 to the number that is passed as an argument
4. If no argument is passed, it should print an error message and exit with exit code 1
5. If the argument is a negative number, it should print an error message and exit with exit code 3
6. If the argument is a positive number, it should count from 1 to that number and print each number on a new line
7. If the argument is 0, it should print an error message and exit with exit code 4
8. Once the counting is finished, it should print "Counting finished" and exit with exit code 0

##### Solution

first we create a new script called counter.sh
```bash
$ touch counter.sh
$ chmod 755 counter.sh
$ subl counter.sh
```
then we write this in the script
```
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

```
then we run the script
```bash
$ ./counter.sh 10
```
and we get this output
```
COUNTING FROM 1 TO 10
1
2
3
4
5
6
7
8
9
10
Counting finished
```
then we run this
```bash
$ ./counter.sh
```
and we get this output
```
No parameters are passed
```
then we run this
```bash
$ ./counter.sh -10
```
and we get this output
```
No negative numbers are allowed
```
then we run this
```bash
$ ./counter.sh 0
```
and we get this output
```
Zero is not allowed
```
