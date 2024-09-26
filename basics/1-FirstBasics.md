# Linux Fundementals Notes

In here i have assumed that a linux machine is already installed and running whether it is a virtual machine or a physical machine. For more knowledge on different distributions and its concepts and how to install one, you can refer to these resources:
- [Linux Distributions - GeekForGeeks](https://www.geeksforgeeks.org/what-are-linux-distributions/)
- Linux History and Concept 
    - [GNU Project](https://www.gnu.org/home.en.html) 
    - [Linus Torvalds](https://en.wikipedia.org/wiki/Linus_Torvalds)
    - [Free Software Foundation](https://www.fsf.org/)
- Linux Distributions 
    - [Debian](https://www.debian.org/)
    - [Red Hat](https://www.redhat.com/en)
    - [Arch Linux](https://archlinux.org/)
    - [OpenSUSE](https://www.opensuse.org/)
- Release Cycles, Stable vs Rolling Release
    - [Stable vs Rolling Release - How-to Geek](https://www.howtogeek.com/192939/linux-distribution-basics-rolling-releases-vs.-standard-releases/)

## Essential Basic Commands 

- **ls** - List directory contents
- **pwd** - Print working directory
- **cd** - Change directory
- **cp** - Copy files and directories
- **mv** - Move files and directories
- **cat** - Concatenate and display files
- **touch** - Create an empty file
- **rm** - Remove files or directories
- **mkdir** - Make directories
- **rmdir** - Remove empty directories
- **chmod** - Change file permissions
- **chown** - Change file owner and group
- **ps** - Process status
- **top** - Display and update sorted information about processes
- **history** - Display the history of commands
- **clear** - Clear the terminal screen
- **date** - Display the current date and time
- **whoami** - Display the current user
- **su** - Switch user
- **sudo** - Execute a command as another user
- **passwd** - Change a user's password
- **appropos** - search the manual page names and descriptions
- **mandb** - create or update the manual page index cache
- **pinfo** - display the documentation for a command or a program
- **sudo su** - change user to root user
- **su [username]** - change user to another user


## Getting Help with man 

- man -> Systems Programmer's Manual

e.g. `man ls` will display the manual for the `ls` command.

In manuals where the options or commands are in brackets, it means they are optional.

- man man -> Manual for the manual command

e.g. `man man` will display the manual for the `man` command.

- which man Page to use: 

- man pages are stored in mandb
- `man -k <keyword> to search for a keyword in mandb
e.g. man -k user
- man appropos - search the manual page names and descriptions
- **ls** - List directory contents
- **pwd** - Print working directory
- **cd** - Change directory
- **cp** - Copy files and directories
- **mv** - Move files and directories
- **cat** - Concatenate and display files
- **touch** - Create an empty file
- **rm** - Remove files or directories
- **mkdir** - Make directories
- **rmdir** - Remove empty directories
- **chmod** - Change file permissions
- **chown** - Change file owner and group
- **ps** - Process status
- **top** - Display and update sorted information about processes
- **history** - Display the history of commands
- **clear** - Clear the terminal screen
- **date** - Display the current date and time
- **whoami** - Display the current user
- **su** - Switch user
- **sudo** - Execute a command as another user
- **passwd** - Change a user's password
- **appropos** - search the manual page names and descriptions
- **mandb** - create or update the manual page index cache
- **pinfo** - display the documentation for a command or a program
- **sudo su** - change user to root user
- **su [username]** - change user to another user- **ls** - List directory contents
- **pwd** - Print working directory
- **cd** - Change directory
- **cp** - Copy files and directories
- **mv** - Move files and directories
- **cat** - Concatenate and display files
- **touch** - Create an empty file
- **rm** - Remove files or directories
- **mkdir** - Make directories
- **rmdir** - Remove empty directories
- **chmod** - Change file permissions
- **chown** - Change file owner and group
- **ps** - Process status
- **top** - Display and update sorted information about processes
- **history** - Display the history of commands
- **clear** - Clear the terminal screen
- **date** - Display the current date and time
- **whoami** - Display the current user
- **su** - Switch user
- **sudo** - Execute a command as another user
- **passwd** - Change a user's password
- **appropos** - search the manual page names and descriptions
- **mandb** - create or update the manual page index cache
- **pinfo** - display the documentation for a command or a program
- **sudo su** - change user to root user
- **su [username]** - change user to another user
e.g. `man -k user` will search for the keyword `user` in the
manual pages and `man apropos user` will search for the keyword `user` in the manual page names and descriptions.
- mandb - create or update the manual page index cache 

when the mandb wasn't updated by the cronjob, you can update it manually by running `mandb` command.
You'll need sudo privileges to run this command.

- using pipes with man -> `man -k user | grep -i user` this will search for the keyword `user` in the manual pages and
then pipe the output to `grep` to search for the keyword `user` in the output. grep is a command-line utility for 
searching plain-text data sets for lines that match a regular expression. -i flag is used to ignore case distinctions
in both the PATTERN and the input files.

- man -k user | less - this will search for the keyword `user` in the manual pages and then pipe the output to `less`.
less is a command-line utility that displays the contents of a file or a command output one page at a time in your terminal.

## Using pinfo

pinfo is also a command-line utility that displays the documentation for a command or a program

e.g. `pinfo ls` will display the documentation for the `ls` command.

## using /usr/share/doc

- /usr/share/doc contains documentation for installed packages




