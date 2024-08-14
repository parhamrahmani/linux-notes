# Linux Bash Scripting -Part 3


## Environment Variables

### What are environment variables?
Environment variables are variables that are available system-wide and are inherited by all spawned child processes and shells.
### How to list all environment variables?
we can list all environment variables with this command
```bash
$ env
```
and we get an output of all environment variables.

### How to list a specific environment variable?
we can list a specific environment variable with this command
```bash
$ echo $PATH
```
and we get this output
```
/opt/apache-maven-3.6.3/bin:/opt/jdk-13.0.1/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/snap/bin
```
### How to create a new environment variable?
we can create a new environment variable with this command
```bash
$ export NAME=Parham
```
- export is a command that creates a new environment variable.
- NAME is the name of the environment variable.
- Parham is the value of the environment variable.
### How to delete an environment variable?
we can delete an environment variable with this command
```bash
$ unset NAME
```
- unset is a command that deletes an environment variable.
- NAME is the name of the environment variable.
- Parham is the value of the environment variable.

### How to make an environment variable permanent?
we can make an environment variable permanent by adding it to the .bashrc file.
first we open the .bashrc file with sublimetext
```bash
$ subl ~/.bashrc
```
then we add this line to the file
```
export NAME=Parham
```
then we save the file and close it.
then we run this command
```bash
$ source ~/.bashrc
```
- source is a command that reloads the .bashrc file.
- ~/.bashrc is the path to the .bashrc file.
- We need to run this command after we make changes to the .bashrc file.
- We can also use this command to reload the .bashrc file
```bash
$ . ~/.bashrc
```
#### Example
we make a new script called githubtoken.sh
```bash
$ touch githubtoken.sh
$ chmod 755 githubtoken.sh
$ subl githubtoken.sh
```
then we write this in the script
```
#!/usr/bin/env bash

# Variables

TOKEN=$1

# Main

export GITHUB_TOKEN=$TOKEN
echo "GITHUB_TOKEN is $GITHUB_TOKEN"
echo "you can make it permanent by adding this line to the .bashrc file"

# Exit code

exit 0
```
then we run the script
```bash
$ ./githubtoken.sh 123456789
```
then we get this output
```
GITHUB_TOKEN is 123456789
you can make it permanent by adding this line to the .bashrc file
```
then we run this command
```bash
$ echo $GITHUB_TOKEN
```
and we get this output
```
123456789
```

##### Notable environment variables
- $HOME is a special variable that holds the path to the home directory of the current user.
- $PATH is a special variable that holds the path to the directories that contain the executables.
- $PWD is a special variable that holds the path to the current working directory.
- $USER is a special variable that holds the name of the current user.
- $SHELL is a special variable that holds the path to the current shell.
- $TERM is a special variable that holds the type of the current terminal.
- $HOSTNAME is a special variable that holds the name of the current host.
- $LANG is a special variable that holds the current language.
- $EDITOR is a special variable that holds the path to the default editor.
- $SUDO_USER is a special variable that holds the name of the user that invoked sudo.
- $SUDO_UID is a special variable that holds the UID of the user that invoked sudo.
- $SUDO_GID is a special variable that holds the GID of the user that invoked sudo.
- $SUDO_COMMAND is a special variable that holds the command that was executed with sudo.
- $RANDOM is a special variable that holds a random number between 0 and 32767.
- $UID is a special variable that holds the UID of the current user.
- $EUID is a special variable that holds the effective UID of the current user.
- $PPID is a special variable that holds the PID of the parent process.
- $BASH_VERSION is a special variable that holds the version of the current bash shell.
and many more...

#### Exercise
1. Create a new script called env.sh
2. Make it executable
3. Display the value of the following environment variables 
  - computer name
  - home directory
  - user name

##### Solution
first we create a new script called env.sh
```bash
$ touch env.sh
$ chmod 755 env.sh
$ subl env.sh
```
then we write this in the script
```

#!/usr/bin/env bash

# Main

echo "Computer name is $HOSTNAME"
echo "Home directory is $HOME"
echo "User name is $USER"

# Exit code

exit 0
```
then we run the script
```bash
$ ./env.sh
```
and we get this output
```
Computer name is parham
Home directory is /home/parham
User name is parham

```
