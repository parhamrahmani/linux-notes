# Linux Bash Scripting Notes - 1
 From course https://www.linkedin.com/learning/learning-linux-shell-scripting-2018
 
## Shell Scripting Basics


### Printing to the screen
1. making a script executable and opening it in sublime text
- touch creates a new file or updates the timestamp of an existing file
- subl opens the file in sublime text
```bash
$ touch hello.sh
$ subl hello.sh
```
2. writing a script
now in hello.sh

```
echo Hello World!
```
3. execute the script
```bash
$ bash hello.sh
```


### chmod
#### Why do we need to use bash?
for example if we want to execute the script without bash we get this error
```bash
$ ./hello.sh
```
```
./hello.sh : Permission denied
```
to fix this we need to use chmod
```bash
$ chmod 755 hello.sh
```
This will give the script the permission to be executed, but only the owner can write to it.
##### What is chmod?
chmod is a command in linux that changes the permissions of a file or directory.
##### Why do we use ./ before the script name?
./ means the current directory, so we are telling the shell to execute the script in the current directory.


### Comments
we open our script with sublimetext
```bash
$ subl hello.sh
```
and write this
```
# This line prints out Hello World!
echo Hello World!
# This line says the mars is red
echo Mars is red
```


### The Shebang
##### what does shebang do?
it tells the shell what interpreter to use to execute the script. in this case we are using bash.

we open our script with sublimetext
```bash
$ subl hello.sh
```
and write this
```
#!/usr/bin/env bash
# This line prints out Hello World!
echo Hello World!
# This line says the mars is red
echo Mars is red
```
also this works too
```
#!/bin/bash
# This line prints out Hello World!
echo Hello World!
# This line says the mars is red
echo Mars is red
```
The difference between these two is that the first one uses the env command to find bash in the system, 
but the second one uses the bash command to find bash in the system. The first one is more portable. Portability 
is the ability of an application to run on different platforms (operating systems) with or without minimal changes.

For example if the script is in python we can use this
```
#!/usr/bin/env python
```

if we write a non-existent or wrong interpreter in the shebang, the script will not run. We get this error
in our script we wrote invalid as the interpreter

```
#!/usr/bin/env invalid
# This line prints out Hello World!
echo Hello World!
# This line says the mars is red
echo Mars is red
```
and we get this error when we try to execute the script
```bash
$ ./hello.sh
```
the error :
```
/usr/bin/env : 'invaild': No such file or directory
```

### Variables
##### What is a variable?
A variable is a container for a value. It can be a number, a string, a list, or any other type of data.
###### Variables characteristics and rules
- Must begin with a letter or underscore
- Any character after the first character can be a letter, underscore, or number
- Variable names are case-sensitive
- Usually all uppercase or all lowercase (not required)
- There are some reserved words that you cannot use as a variable name because 
they have a special meaning to the shell. For example, if, then, else, fi, case, etc.
- If values have spaces in them, you need to use quotes around the value.
  - For in our script if we type
  ```
    NAME= Parham
    ```
  instead of
  ```
    NAME=Parham
    ```
  we get this error
    ```
     Parham : command not found
    ```
    - Also if we type
    ```
    NAME=Parham Rahmani
    ```
    instead of
    ```
    NAME="Parham Rahmani"
    ```
    we get this error
    ```
  Rahmani : command not found
    ```
 #### How to define a variable? 
First we create a new script
```bash
$ touch greeting.sh
$ chmod 755 greeting.sh
$ subl greeting.sh
```
and write this
```
#!/usr/bin/env bash

FIRST_NAME=Parham
FAVORITE_COLOR=Black

echo Hi $FIRST_NAME, your favorite color is $FAVORITE_COLOR ! 
```
then we execute the script
```bash
$ ./greeting.sh
```
and we get this output
```
Hi Parham, your favorite color is Black !
```

### Parameters
#### What are parameters?
Parameters are variables that store the arguments that are passed to the script when it is executed.
##### Parameter characteristics and rules
- $0 is the name of the script itself
- $1 is the first argument, $2 is the second argument, $3 is the third argument, etc.
- Usually we don't use parameters more than 9, but if we want to use them we need to use curly braces
  - $1, $2, $3, $4, $5, $6, $7, $8, $9, ${10}, ${11}, ${12}, etc.
#### How to fill a parameter?
first we create a new script
```bash
$ params.sh
$ chmod 755 params.sh
$ subl params.sh
```
in the script we write this
```
#!/usr/bin/env bash

echo The name of the script is $0
echo The first argument is $1

```
then we execute the script
```bash
$ ./params.sh Parham
```
and we get this output
```
The name of the script is ./params.sh
The first argument is Parham
```
* It is generally considered bad practice to work directly with positional parameters in a script. 
* Since they are not very descriptive, it is better to assign them to named variables first.
Assingning parameters to variables is a good practice because it makes the script more readable and easier to maintain.
#### How to assign parameters to variables?
first we open our script with sublimetextn and write this
```
#!/usr/bin/env bash

USER_NAME=$1

echo The name of the script is $0
echo Hello $1 !
```
then we execute the script
```bash
$ ./params.sh Parham
```
and we get this output
```
The name of the script is ./params.sh
Hello Parham !
```
##### Adding date to the script
first we open our script with sublimetextn and write this
```
#!/usr/bin/env bash

USER_NAME=$1
DATE=$(date)

echo The name of the script is $0
echo Hello $1 !
echo Today is $DATE
```
then we execute the script
```bash
$ ./params.sh Parham
```
and we get this output
```
The name of the script is ./params.sh
Hello Parham !
Today is Di 9. Jan 19:36:14 CET 2024

```
- $ and () are used to execute a command and assign the output of the command to a variable.
- 
 We also can see the printing working directory with this command
 ```
#!/usr/bin/env bash

USER_NAME=$1
DATE=$(date)

echo The name of the script is $0
echo Hello $1 !
echo Today is $DATE
echo Wrking directory : $(pwd)
```
we run the script
```bash
$ ./params.sh Parham
```
and we get this output
```
The name of the script is ./params.sh
Hello !
Today is Di 9. Jan 19:43:51 CET 2024
Working directory : /home/parham/linuxLearning

```
- pwd is a command that prints the working directory. Working directory is the directory that we are currently in.

We also can return the number zero as the exit code of the script with this command. WHich means that the script ran successfully.
```
#!/usr/bin/env bash

USER_NAME=$1
DATE=$(date)

echo The name of the script is $0
echo Hello $1 !
echo Today is $DATE
echo Working directory : $(pwd)

exit 0
```
we run the script
```bash
$ ./params.sh Parham
```
and we get this output
```
The name of the script is ./params.sh
Hello Parham !
Today is Di 9. Jan 19:43:51 CET 2024
Working directory : /home/parham/linuxLearning

```
Then we can check the exit code of the script with this command
```bash
$ echo $?
```
and we get this output
```
0
```
- $? is a special variable that holds the exit code of the last command that was executed.
- 0 means that the command was executed successfully.
- if we change the exit code to 100 in the script. When we run $? we get 100 as the output.
Which still means that the script ran successfully.
 - $? return the last exit code of the last command that was executed. 
In this case the last command that was executed was exit 100.
 - If we run $? after the echo command we get 0 as the output because the echo command was executed successfully.

#### Excersise
1. Create a new script called sports.sh
2. Make it executable
3. Accept two parameters: the name of user and the name of favorite sport
4. Display any sentence you want that includes the values of the parameters

##### Solution

With touch we create a new script called sports.sh and then with chmod we make it executable. With subl we open
the script in sublime text.
```bash
$ touch sports.sh
$ chmod 755 sports.sh
$ subl sports.sh
```
then we write this in the script
```
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
```
then we run the script
```bash
$ ./sports.sh Parham Football
```
and we get this output
```
Working directory : /home/parham/linuxLearning Time : Di 9. Jan 19:57:28 CET 2024
The name of the script : ./sport.sh
Hello Parham ! Your favorite sport is Football !

```
then we run this command
```bash
$ echo $?
```
and we get this output
```
100
```
