# Linux Bash Scripting -Part 7
## Interacting with the user - Interactive Scripts

### How to read user input?
we can read user input with this command
```bash
$ read NAME
```
- read is a command that reads user input.
- NAME is a variable that holds the user input.
- we can read multiple variables like this
```bash
$ read NAME AGE
```

Let's create a new script called prompt.sh
```bash
$ touch prompt.sh
$ chmod 755 prompt.sh
$ subl prompt.sh
```
then we write this in the script
```
#!/usr/bin/env bash

read -p "What is your name: " NAME
echo "Your name is: $NAME"

exit 0
```
- -p is an option that displays a prompt.

then we run the script
```bash
$ ./prompt.sh
```
output:
```
What is your name: Parham
Your name is: Parham
```
### Handling user input and bad data
Let's create a new script called user.sh
```bash
$ touch user.sh
$ chmod 755 user.sh
$ subl user.sh
```
then we write this in the script
```
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
```
- -z is an option that checks if the variable is empty.
- -n is an option that checks if the variable is not empty.
- =~ is an operator that checks if the variable matches the regular expression.
  - ^ is a regular expression that matches the beginning of the string.
  - $ is a regular expression that matches the end of the string.
  - [A-Za-z] is a regular expression that matches all the alphabetic characters.
  - + is a regular expression that matches one or more of the previous character.
  + [0-9] is a regular expression that matches all the digits.
  + * is a regular expression that matches zero or more of the previous character.

Then we run the script
```bash
$ ./user.sh
```
output:
```
Please enter your name and age: 
Not enough params passed
Please enter your name and age: P2ham rt
Non alpha characters detected [P2ham]
Please enter your name and age: Parham rt
Non-digit characters detected [rt]
Please enter your name and age: Parham 26
Name = Parham and Age = 26

```

#### Exercise
1. create a new script called guess.sh
2. Make it executable
3. Set a global variable named COMPUTER to a number between 1 and 50
4. Ask the user to guess the number
5. let them knwo if they are too high or too low

##### Solution
first we create a new script called guess.sh
```bash
$ touch guess.sh
$ chmod 755 guess.sh
$ subl guess.sh
```
then we write this in the script
```
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
```

then we run the script
```bash
$ ./guess.sh
```
output:
```
Please guess a number between 1 to 50!
No param passed
Please guess a number between 1 to 50!2d
Non-digit characters detected [2d]
Please guess a number between 1 to 50!12
your guess is lower than expected
Please guess a number between 1 to 50!35
Your guess is higher than expected
Please guess a number between 1 to 50!34
Your guess is right! [34]
Game Over
```










