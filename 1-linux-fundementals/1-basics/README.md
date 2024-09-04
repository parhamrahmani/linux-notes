### Basics
This directory contains notes on basic linux commands and concepts.
#### TL;DR
##### Cheat Sheet

| Command       | Description                                      |
|---------------|--------------------------------------------------|
| `ls`          | List directory contents                          |
| `pwd`         | Print working directory                          |
| `cd`          | Change directory                                 |
| `cp`          | Copy files and directories                       |
| `mv`          | Move files and directories                       |
| `cat`         | Concatenate and display files                    |
| `touch`       | Create an empty file                             |
| `rm`          | Remove files or directories                      |
| `mkdir`       | Make directories                                 |
| `rmdir`       | Remove empty directories                         |
| `chmod`       | Change file permissions                          |
| `chown`       | Change file owner and group                      |
| `ps`          | Process status                                   |
| `top`         | Display and update sorted information about processes |
| `history`     | Display the history of commands                  |
| `clear`       | Clear the terminal screen                        |
| `date`        | Display the current date and time                |
| `whoami`      | Display the current user                         |
| `su`          | Switch user                                      |
| `sudo`        | Execute a command as another user                |
| `passwd`      | Change a user's password                         |
| `appropos`    | Search the manual page names and descriptions    |
| `mandb`       | Create or update the manual page index cache     |
| `pinfo`       | Display the documentation for a command or a program |
| `sudo su`     | Change user to root user                         |
| `su [username]` | Change user to another user                    |

### Getting Help with man

- ``man`` -> Systems Programmer's Manual
  e.g. `man ls` will display the manual for the `ls` command.

  In manuals where the options or commands are in brackets, it means they are optional.

- ``man man`` -> Manual for the manual command

  e.g. `man man` will display the manual for the `man` command.

- **which man Page to use**:

  - Man pages are stored in `mandb`.
  - `man -k <keyword>` to search for a keyword in `mandb`.

    e.g. `man -k user` will search for the keyword `user` in the manual pages.

  - `man apropos` - Search the manual page names and descriptions.

  - ``mandb`` - Create or update the manual page index cache.

    When the `mandb` wasn't updated by the cronjob, you can update it manually by running the `mandb` command. You'll need sudo privileges to run this command.

  - Using pipes with `man`:

    - `man -k user | grep -i user` - This will search for the keyword `user` in the manual pages and then pipe the output to `grep` to search for the keyword `user` in the output. `grep` is a command-line utility for searching plain-text data sets for lines that match a regular expression. The `-i` flag is used to ignore case distinctions in both the PATTERN and the input files.

    - `man -k user | less` - This will search for the keyword `user` in the manual pages and then pipe the output to `less`. `less` is a command-line utility that displays the contents of a file or a command output one page at a time in your terminal.
