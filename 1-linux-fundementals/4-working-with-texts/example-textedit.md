# Working with Texts Example
## Description
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
## Solution
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
