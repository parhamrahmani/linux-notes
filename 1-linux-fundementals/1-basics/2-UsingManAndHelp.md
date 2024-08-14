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