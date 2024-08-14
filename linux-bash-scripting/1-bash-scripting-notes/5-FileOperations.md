
# Linux Bash Scripting -Part 5

## File Operations

### How to create a file?
we can create a file with this command
```bash
$ touch file.txt
```
### How to create a directory?
we can create a directory with this command
```bash
$ mkdir directory
```
### How to copy a file?
we can copy a file with this command
```bash
$ cp file.txt file2.txt
```
### How to copy a directory?
we can copy a directory with this command
```bash
$ cp -r directory directory2
```
### How to move a file?
we can move a file with this command
```bash
$ mv file.txt directory
```
### How to move a directory?
we can move a directory with this command
```bash
$ mv directory directory2
```
### How to rename a file?
we can rename a file with this command
```bash
$ mv file.txt file2.txt
```
### How to rename a directory?
we can rename a directory with this command
```bash
$ mv directory directory2
```
### How to delete a file?
we can delete a file with this command
```bash
$ rm file.txt
```
### How to delete a directory?
we can delete a directory with this command
```bash
$ rm -r directory
```
### Reading files
let's create a text file called names.txt
```bash
$ touch names.txt
$ subl names.txt
```
then we write this in the file
```
PARHAM
JOHN
TOM
RENE
RICHARD
```
then we create a new script called read.sh
```bash
$ touch read.sh
$ chmod 755 read.sh
$ subl read.sh
```
then we write this in the script
```
#!/usr/bin/env bash

COUNT=1

while IFS='' read -r LINE
do
	echo "LINE $COUNT: $LINE"
	((COUNT++))
done < "$1"

exit 0
```
- IFS is a special variable that holds the Internal Field Separator.
- -r is an option that prevents backslash escapes from being interpreted.
- $LINE is a variable that holds the current line.
- $1 is a variable that holds the first argument that is passed to the script.
- < is a redirection operator that redirects the input of the while loop to the file that is passed as an argument to the script.

then we run the script
```bash
$ ./read.sh names.txt
```
and we get this output
```
LINE 1: PARHAM
LINE 2: JOHN
LINE 3: TOM
LINE 4: RENE
LINE 5: RICHARD
```

### Writing to files
let's send the output of the script to a file called output.txt

```bash
$ ./read.sh names.txt > output.txt
```
- > is a redirection operator that redirects the output of the script to the file that is passed as an argument to the script.
  > overwrites the file if it already exists.
  > creates the file if it doesn't exist.
  > if we want to append the output to the file we can use >> instead of >.
  > >> appends the output to the file if it already exists.
  > >> creates the file if it doesn't exist.
  > if we want to redirect the error output to a file we can use 2> instead of >.
  > 2> redirects the error output to the file that is passed as an argument to the script.
  > 2> overwrites the file if it already exists.
  > 2> creates the file if it doesn't exist.
  > if we want to append the error output to the file we can use 2>> instead of 2>.
  > 2>> appends the error output to the file if it already exists.
  > 2>> creates the file if it doesn't exists.
      - Difference between append and overwrite
      > append adds the output to the end of the file.
      > overwrite replaces the content of the file with the output.
 
Let's see the result
```bash
$ cat output.txt
```
and we get this output
```
LINE 1: PARHAM
LINE 2: JOHN
LINE 3: TOM
LINE 4: RENE
LINE 5: RICHARD
```
#### Example
As we did before, Let's pass the read.sh script as an argument to the output.txt file
```bash
$ ./read.sh names.txt > output.txt
```
then we run this command
```bash
$ cat output.txt
```
and we get this output
```
LINE 1: PARHAM
LINE 2: JOHN
LINE 3: TOM
LINE 4: RENE
LINE 5: RICHARD
```
Now we can also do this:

```bash
$ ./read.sh names.txt >> output.txt
```
then we run this command
```bash#
cat output.txt
```
and we get this output
```
LINE 1: PARHAM
LINE 2: JOHN
LINE 3: TOM
LINE 4: RENE
LINE 5: RICHARD
LINE 1: PARHAM
LINE 2: JOHN
LINE 3: TOM
LINE 4: RENE
LINE 5: RICHARD
```
- >> is a redirection operator that appends the output of the script to the file that is passed as an argument to the script.
  > appends the output to the file if it already exists.
  > creates the file if it doesn't exist.

#### Useful example
Let's create a script called savevariable.sh
This script takes a name and value as parameters and saves it as a environment variable.
Then append the environment variable to the .bashrc file.
- If the the environment variable already exists, it should overwrite it.
- If the the environment variable doesn't exist, it should create it.
- If no argument is passed, it should print an error message and exit with exit code 1.

```bash
$ touch savevariable.sh
$ chmod 755 savevariable.sh
$ subl savevariable.sh
```
then we write this in the script

```
#!/usr/bin/env bash

# Variables
VAR_NAME=$1
VAR_VALUE=$2

# Main
if [ "$#" -ne 2 ]; then
    echo "Error: Please provide both variable name and value as parameters."
    exit 1
else
    # Check if the variable already exists
    if grep -q "^export $VAR_NAME=" ~/.bashrc; then
        # Update existing variable
        sed -i "s/^export $VAR_NAME=.*/export $VAR_NAME=$VAR_VALUE/" ~/.bashrc
    else
        # Create new variable
        echo "export $VAR_NAME=$VAR_VALUE" >> ~/.bashrc
    fi

    # Set the variable for the current session
    export $VAR_NAME=$VAR_VALUE

    # Source the .bashrc file to apply changes in the current session
    source ~/.bashrc

    echo "Variable '$VAR_NAME' with value '$VAR_VALUE' has been saved to .bashrc."
fi
```
- sed is a command that searches for a pattern in a file and replaces it with another pattern.
- sed -i is a command that edits the file in place.
- sed -i "s/^export $VAR_NAME=.*/export $VAR_NAME=$VAR_VALUE/" ~/.bashrc is a command that
  searches for a line that starts with export $VAR_NAME= and replaces it with export $VAR_NAME=$VAR_VALUE.
- grep is a command that searches for a pattern in a file.
- grep -q is a command that searches for a pattern in a file and suppresses the output.
- grep -q "^export $VAR_NAME=" ~/.bashrc is a command that searches for a line that starts with export $VAR_NAME= in the .bashrc file.
- echo "export $VAR_NAME=$VAR_VALUE" >> ~/.bashrc is a command that appends export $VAR_NAME=$VAR_VALUE to the .bashrc file.
- source is a command that reloads the .bashrc file.
- ~/.bashrc is the path to the .bashrc file.

then we run the script
```bash
$ ./savevariable.sh GITHUB_TOKEN somevalue
```
and we get this output
```
Variable 'GITHUB_TOKEN' with value 'somevalue' has been saved to .bashrc.
```
then we run this command
```bash
$ echo $GITHUB_TOKEN
```
and we get this output
```
somevalue
```
then we run this command
```bash
$ ./savevariable.sh GITHUB_TOKEN someothervalue
```
and we get this output
```
Variable 'GITHUB_TOKEN' with value 'someothervalue' has been saved to .bashrc.
```
then we run this command
```bash
$ echo $GITHUB_TOKEN
```
and we get this output
```
someothervalue
```
then we run this command
```bash
$ cat ~/.bashrc | grep GITHUB_TOKEN
```
and we get this output
```
export GITHUB_TOKEN=someothervalue
```
#### checksum
What is a checksum?
A checksum is a sequence of numbers and letters that can be used to check if a file is genuine.
How to calculate a checksum?
We can calculate a checksum with this command
```bash
$ cksum file.txt
```
Now let's do this with names.txt
```bash
$ cksum names.txt
```
and we get this output
```
3000754333 29 names.txt
```
- 3000754333 is the checksum.
- 29 is the size of the file in bytes.
- names.txt is the name of the file.
Now if we change the content of the file and run the command again we get this output
```
PARHAM
JOHN
TOM
RENE
RICHARDe
```
let's run the command again
```bash
$ cksum names.txt
```
and we get this output
```
3478808517 30 names.txt
```
the size of the file has changed and the checksum has changed too.

Now let's roll back the changes and run the command again
```
PARHAM
JOHN
TOM
RENE
RICHARD
```
```bash
$ cksum names.txt
```
and we get this output
```
3000754333 29 names.txt
```
the size of the file has changed back to 29 and the checksum has changed back to 3000754333.

#### Exercise
1. Create a new script called read3.sh
2. Have it read a file name passed as a parameter
3. It should only display the first three lines of the file, with counts

##### Solution
first we create a new script called read3.sh
```bash
$ touch read3.sh
$ chmod 755 read3.sh
$ subl read3.sh
```
then we write this in the script
```
#!/usr/bin/env bash

# Variables

COUNT=1

# Main

while IFS='' read -r LINE
do
	echo "LINE $COUNT: $LINE"
	if [ $COUNT -ge 3 ]
	then 
		break 
	fi
	((COUNT++))
done <"$1"

exit 0


```
- we use < "$1" to read the file that is passed as an argument to the script.
then we run the script
```bash
$ ./read3.sh names.txt
```
as we can see it only displays the first three lines of the file, with counts
```
LINE 1: PARHAM
LINE 2: JOHN
LINE 3: TOM
```