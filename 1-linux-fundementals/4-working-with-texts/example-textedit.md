# Working with Texts Example
## Excercise 1
### Description
- use `vim` to create a text file. 
- write this text in the file:
```text
# This is a text file
## This is a heading
### Senior Team Members
- jame
- jameston
- jill
### Junior Team Members
- johnson
- sara
- john 
### Interns
- anna
- annabelle
- bella
- annna
- belle anna
- anna belle
```
- use `grep` to filter all lines that contain `anna` and save them to a new file named `annas.txt`
- use the appropriate tool to only print the last line from the text file.
- print the content of this text file on screen in reversed order.
### Solution
- create a text file using `vim`:
```bash
vim /tmp/text.txt
```
- press `i` to enter insert mode and type the text.
- write the text and save and exit using `Esc` key to enter `command mode`, then type `:wq` and press `Enter`.
- use `grep` to filter all lines that contain `anna` and save them to a new file named `annas.txt`:
```bash
grep 'anna' /tmp/text.txt > /tmp/annas.txt
```
let's cat the file to see if the lines are filtered:
```bash
cat /tmp/annas.txt
``` 
```text
- anna
- annabelle
- belle anna
- anna belle
```
- use the appropriate tool to only print the last line from the text file:
```bash
tail -n 1 /tmp/text.txt
```
```
- anna belle
``` 
- print the content of this text file on screen in reversed order:
```bash
tac /tmp/text.txt
```
```text
- anna belle
- belle anna
- annna
- bella
- annabelle
- anna
### Interns
- john
- sara
- johnson
### Junior Team Members
- jill
- jameston
- jame
### Senior Team Members
## This is a heading
```	
## Excercise 2
### Description
- Use `sed` to delete the 5th line fo file `users` in the last exercise.
- Use `awk` in a pipe to filter the first column out of the results of the command ps aux.
- Use `grep` to show the names of all files in /etc that have lines starting with *root*.
- Use `grep` to show all lines from all files in users that contain three letters `n`.
- Use `grep` to find all files that contain the string *anna* where nothing occurs behind the string.
### Solution 
######  Use `sed` to delete the 5th line fo file `users` in the last exercise.
First Use `sed` to display the 5th line fo file `users` in the last exercise:
```bash
sed -n '5p' /tmp/users
```
```
- jameston
```
Then use sed to delete the line
```bash
sed -i -e '5d' /tmp/users
```
```
# This is a text file
## This is a heading
### Senior Team Members
- jame
- jill
### Junior Team Members
- johnson
- sara
- john
### Interns
- anna
- annabelle
- bella
- annna
- belle anna
- anna belle
```
###### Use `awk` in a pipe to filter the first column out of the results of the command ps aux.
```bash
ps aux | awk '{print $1}'
```
By default `awk` uses space as a delimiter, so it will print the first column of the output of `ps aux` which is the username. Other columns can be printed by changing the number in the curly braces and other delimiters can be used by specifying the `-F` option.
###### Use `grep` to show the names of all files in /etc that have lines starting with *root*.
```bash 
sudo grep -l '^root' /etc/* 2>/dev/null
```
```
/etc/group
/etc/group-
/etc/gshadow
/etc/gshadow-
/etc/mtab
/etc/passwd
/etc/passwd-
/etc/services
/etc/shadow
/etc/shadow-
/etc/sudoers
```
###### Use `grep` to show all lines from all files in users that contain three letters `n`.
```bash
grep 'n\{3\}' /tmp/users
```
```
- annna
```
###### Use `grep` to find all files that contain the string *anna* where nothing occurs behind the string.
```bash
sudo grep -R 'anna$' /etc/* 2>/dev/null
```


