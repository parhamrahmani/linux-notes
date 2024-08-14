# Linux Bash Scripting -Part 4

## Functions

### What are functions?
Functions are blocks of code that can be executed multiple times.
### How to define a function?
the basic syntax of defining a function is this
```
function_name() {
    statement
}
```
for example we can define a function called hello
```
hello() {
    echo Hello World!
}
```
Let's create a new script called functions.sh
```bash
$ touch functions.sh
$ chmod 755 functions.sh
$ subl functions.sh
```
then we write this in the script
```
#!/usr/bin/env bash

# first way to make a function

function Hello() {
echo "Hello!"
}

#  second way

 Goodbye(){
 echo "Goodbye!"
 }
 
 echo "Calling the Hello function"
    Hello
    echo "Calling the Goodbye function"
    Goodbye
    

exit 0
```
then we run the script
```bash
$ ./functions.sh
```

and we get this output
```
Calling the Hello function
Hello!
Calling the Goodbye function
Goodbye!
```
- functions must be defined before they are called.

### Passing parameters to functions
we can pass parameters to functions like this
```
function_name() {
    statement
}
```
for example we can define a function called hello
```
hello() {
    echo Hello $1 !
}
```
Let's use this function in our last example 
```
#!/usr/bin/env bash

# first way to make a function

function Hello() {
  local NAME=$1
echo "Hello $NAME !"
}

#  second way

 Goodbye(){
    local NAME=$1
 echo "Goodbye $NAME !"
 }
 
 echo "Calling the Hello function"
    Hello Parham
    echo "Calling the Goodbye function"
    Goodbye Parham

exit 0
```
- local is a command that makes a variable local to the function.
- local variables are variables that are only available inside the function.

then we run the script
```bash
$ ./functions.sh
```

and we get this output
```
Calling the Hello function
Hello Parham !
Calling the Goodbye function
Goodbye Parham !
```
### Piping
Piping is a way to connect the output of one command to the input of another command.
#### How to use piping?
we can use piping like this
```
command1 | command2
```
for example we can use piping like this
```bash
$ ls | grep .sh
```
- ls is a command that lists the files and directories in the current directory.
- grep is a command that searches for a pattern in a file or in the output of another command.
- .sh is a pattern that matches all the files that end with .sh

then we get this output
```
counter.sh
env.sh
for.sh
functions.sh
githubtoken.sh
greeting.sh
hello.sh
if.sh
params.sh
sport.sh
while.sh

```
Let's create a new script called pipe.sh
```bash
$ touch pipe.sh
$ chmod 755 pipes.sh
$ subl pipes.sh
```
then we write this in the script
```
#!/usr/bin/env bash

FILES=`ls -1 | sort -r | head -3`
COUNT=1

for FILE in $FILES 
do
	echo "File #$COUNT = $FILE"
	((COUNT++))
done

exit 0
```
what does this script do?
- ls -1 is a command that lists all the files and directories in the current directory.
- sort -r is a command that sorts the output of the previous command in reverse order.
- head -3 is a command that prints the first 3 lines of the output of the previous command.
- $FILES is a variable that holds the output of the previous command.

then we run the script
```bash
$ ./pipe.sh
```
and we get this output
```
File #1 = while.sh
File #2 = sport.sh
File #3 = params.sh
```

#### Exercise
1. Create a new script called pfunc.sh
2. Make it executable
3. Create two functions GetFiles() and ShowFiles()
4. GetFiles() returns the first 10 files in the current directory
5. Tip: there is no easy way to return values from a function --> go with what you know
6. ShowFiles() prints the files that are passed as arguments
7. ShowFiles takes the array of files as a parameters and then displays each one with a counter

##### Solution

first we create a new script called pfunc.sh
```bash
$ touch pfunc.sh
$ chmod 755 pfunc.sh
$ subl pfunc.sh
```
then we write this in the script
```
#!/usr/bin/env bash

# Variables


COUNT=1

# Define functions
function GetFiles()
{
FILES=`ls -1 | sort | head -10` 
}

function ShowFiles()
{
local COUNT=1
for FILE in $@
do 
	echo "FILE #$COUNT - $FILE"
	((COUNT++))
done
}

GetFiles
ShowFiles $FILES
exit 0
```
then we run the script
```bash
$ ./pfunc.sh
```
and we get this output
```
FILE #1 - counter.sh
FILE #2 - env.sh
FILE #3 - for.sh
FILE #4 - func.sh
FILE #5 - githubtoken.sh
FILE #6 - greeting.sh
FILE #7 - hello.sh
FILE #8 - if.sh
FILE #9 - params.sh
FILE #10 - pfunc.sh
```
