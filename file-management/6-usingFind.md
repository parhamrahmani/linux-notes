# Using the find command

## Basic Usage

### name based search
```bash
find /path/to/search -name "filename"
```
e.g.
```bash
sudo find / -name "passwd"
```

### user based search
```bash
find /path/to/search -user username
``` 
### size based search
```bash
find /path/to/search -size +1M
```
e.g.
```bash
sudo find /home -size +5M 
```
### -exec option
the `exec` option lets you to use the output of the find command to execute another command.

e.g.
```bash
mkdir tmp/test ; sudo find /home -size +2M -exec cp {} /tmp/test \;
```
After creating a directory called test in /tmp. this will find files bigger than 2M in /home directory and copy them to /tmp/test directory. the `\` is used to end the command. This is called escaping the semicolon. The `{}` is used to represent the output of the find command.

### permission based search
```bash
find /path/to/search -perm /4000
```
This will find files with setuid permission. Setuid permission is dangerous as it allows the user to run the file as the owner of the file.

## More advanced usage

### finding files combining multiple options
```bash
sudo find / -type f -size +5M
```
This will find files bigger than 5M in the root directory. Only files are searched as `-type f` is used.
### using grep with find
```bash
 sudo find /etc -type f -exec grep -l "root" {} \;
```
This will find *files* in /etc directory that contains the word "root". The `-l` flag is used to display the file name only.
### using wildcards with find
```bash
sudo find /etc/ -name '*.conf' -type f -exec cp {} /tmp/test \;
```
this will find files in /etc directory that ends with `.conf` and copy them to /tmp/test directory.
or
```bash
sudo find /etc/ -name '*' -type f | xargs grep "127.0.0.1" 2>/dev/null
```
xargs is used to pass the output of the find command to grep. ***`2>/dev/null` is used to suppress the error messages.***
Since we are using pipes, the error messages for find will be shown anyway but the error messages of grep will be suppressed.


## locate and which commands

### locate
`locate` is a command that is used to search for files in the system. It is faster than `find` as it uses a database to search for files. The database is updated by the `updatedb` command. The database is updated daily by a `cron` job.
#### example
```bash
sudo touch /home/user/testfile.txt
locate testfile.txt
```
This won't find the file because the database is not updated. To update the database, run `sudo updatedb` and then run `locate testfile.txt` again. This time it will find the file.
```bash
sudo updatedb
locate testfile.txt
```
```
/home/user/testfile.txt
```
### which *(very useful)*
`which` is a command that is used to find the exact location of binary files from the $PATH variable.

#### example
let's find the exact location of the `ls` command.
```bash
which ls
```
```
alias ls='ls --color=auto'
        /usr/bin/ls
```

*which is only used when the command is in the $PATH variable. If the command is not in the $PATH variable, it will return nothing.*
