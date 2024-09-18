# Working with Texts
This chapter covers the following topics:
- Text Editors in Linux
- Browsing and Searching Text Files
#### Detailed Notes
- [Text Editors in Linux](/1-linux-fundementals/4-working-with-texts/9-texted-vivimnanogedit.md)
- [Browsing and Searching Text Files](/1-linux-fundementals/4-working-with-texts/10-BrowsingAndSearchingTextFiles.md)
- [Examples](/1-linux-fundementals/4-working-with-texts/example-textedit.md)
#### TL;DR
##### Text Editors in Linux
- `vi` is a text editor that is available in almost all linux distributions.
- `vim` is an improved version of `vi` with more features.
- `nano` is a simple text editor that is available in some linux distributions.
- `gedit` is a graphical text editor that is available in few linux distributions by default.
- To change the default text editor in linux, use 
```bash
export EDITOR=$(which <editorname>)
```
##### cheat sheet
| Command | Description | Example |
| --- | --- | --- |
| `vi` | open a file in `vi` | `vi /tmp/newfile.txt` |
| `vim` | open a file in `vim` | `vim /tmp/newfile.txt` |
| `nano` | open a file in `nano` | `nano /tmp/newfile.txt` |
| `gedit` | open a file in `gedit` | `gedit /tmp/newfile.txt` |
###### ``vi`` and ``vim``
| Command | Description |
| --- | --- | 
| `w` | save the file | 
| `b` | move to the beginning of the word | 
| `^` | move to the beginning of the line | 
| `$` | move to the end of the line |
| `dw` | delete a word |
| `dd` | delete a line |
| `u` | undo the last operation |
| `ctrl` + `r` | redo the last operation |
| `o` | insert a new line below the cursor |
| `O` | insert a new line above the cursor |
| `:se number` | show line numbers |
| `r` | replace a character |
| `:%s/old/new/g` | search and replace all occurrences of `old` with `new` |
| `:noh` | clear highlighted search results |
| `:wq` | save and exit |
| `:q!` | exit without saving |
| `:wq!` | save and exit forcefully |
| `i` | enter insert mode |
| `Esc` | exit insert mode |
| `v` | enter visual mode |	
| `ctrl` + `v` | enter visual block mode |
| `y` | copy selected text |    
| `p` | paste copied text |
| `x` | delete selected text |
| `yy` | copy a line |
##### modes in ``vi`` and ``vim``
###### ``vi`` modes
![vi modes](vi.drawio.png)
###### ``vim`` modes
![vim modes](vim.drawio.png)

#### Browsing and Searching Text Files
##### ``more`` and ``less``, ``head`` and ``tail``, `cat` and ``grep``
##### cheat sheets
###### `head` and `tail`
|Command | 	Description|
| --- | --- |
|head file.txt | Display the first 10 lines of file.txt.
|head -n 5 file.txt	 | Display the first 5 lines of file.txt.
|head -c 20 file.txt |	Display the first 20 bytes of file.txt.
|tail file.txt	| Display the last 10 lines of file.txt.
|tail -n 5 file.txt	| Display the last 5 lines of file.txt.
|tail -f file.txt	| Follow the content of file.txt as it grows.
|tail -c 20 file.txt	| Display the last 20 bytes of file.txt.


`ls -l | head -n 5` - ***Display the first 5 lines of the output of ls -l.***
`ls -l | tail -n 5` - ***Display the last 5 lines of the output of ls -l.***
`ls -l | tail -n 5 | head -n 1` - ***Display the output of ls -l starting from line 5.***

Use `-f` option with `tail` to follow the content of a file as it grows, the so called `live mode`. 

###### `cat` Command Cheatsheet
|Command | 	Description|
| --- | --- |
|`cat file.txt`|	Display the content of file.txt.
|`cat file1.txt file2.txt`|	Concatenate and display the content of file1.txt and file2.txt.
|`cat -n file.txt`|	Display the content of file.txt with line numbers.
|`cat file.txt > newfile.txt`|	Redirect the content of file.txt to newfile.txt.
|`cat -b file.txt`|	Display the content of file.txt with line numbers, skipping blank lines.
|`cat -s file.txt`|	Display the content of file.txt, squeezing blank lines.

***Use `-A` option is used to display all characters, including non-printing characters.***


###### ``more`` and ``less`` Command Cheatsheet
|Command | 	Description|
| --- | --- |
|`more file.txt`|	View the content of file.txt one screen at a time.
|`more -N file.txt`|	View the content of file.txt with line numbers.
|`less file.txt`|	View the content of file.txt one screen at a time.
|`less -N file.txt`|	View the content of file.txt with line numbers.

- use `-f` option to view the file in follow mode. Available with `less` command.

###### ``grep`` Command Cheatsheet
|Command | 	Description|
| --- | --- |
|`grep root *`|	Search for the string root in all files in the current directory.
|`grep -i root *`|	Search for the string root in all files in the current directory, ignoring the case.
|`grep -r root /etc`|	Search for the string root in all files in the /etc directory recursively.
|`grep -v root *`|	Invert the match, displaying lines that do not contain root.
|`grep -l root *`|	Display only the names of files that contain root.
|`grep -A5 root *`|	Display 5 lines after each match of root.
|`grep -B5 root *`|	Display 5 lines before each match of root.
|`grep -C5 root *`|	Display 5 lines before and after each match of root.
|`grep root * 2>/dev/null`|	Suppress error messages while searching for root.

###### Using `grep` while piping
```bash
ls -l /etc | grep root
```
***This will search for the string `root` in the output of `ls -l /etc`.***
```bash	
ls -l /etc | grep root | grep -v user
```
***This will search for the string `root` in the output of `ls -l /etc` and exclude the lines that contain `user`.***
```bash
ps aux | grep http
```
***this will search for the string `http` in the output of the `ps aux` command.***

##### `cut`
`cut` is a command-line utility used to extract sections from each line of a file.

| Option | Description |
|--------|-------------|
| `-d`   | Specify the delimiter. |
| `-f`   | Specify the fields to extract. |

###### Examples

| Command | Description |
|---------|-------------|
| `cut -f 3 /etc/passwd` | Display the 3rd field of each line in the `/etc/passwd` file. Without `-d`, it displays the entire line. |
| `cut -d ':' -f 3 /etc/passwd` | Display the 3rd field of each line in the `/etc/passwd` file using `:` as the delimiter. |

##### `sort`
`sort` is usually used with `cut` and `grep` to sort the output.

| Option | Description |
|--------|-------------|
| `-r`   | Sort in reverse order. |
| `-n`   | Sort numerically. |
| `-k`   | Specify the field to sort on. |

###### Examples

| Command | Description |
|---------|-------------|
| `cut -d ':' -f 3 /etc/passwd \| sort -n` | Display the 3rd field of each line in the `/etc/passwd` file and sort them numerically. |

##### `regular expressions`
Regular expressions are text patterns used to search for specific patterns in text. Mostly used in `grep`, `vim`, `sed`, `awk`.

| Symbol | Description | Example |
|--------|-------------|---------|
| `^`    | Matches the beginning of a line. | `^root` matches lines starting with `root`. |
| `$`    | Matches the end of a line. | `root$` matches lines ending with `root`. |
| `\b`   | Matches a word boundary. | `\broot\b` matches lines containing the word `root`. |
| `*`    | Zero or more occurrences of the previous character. | `n.*x` matches lines containing `n` followed by any character and then `x`. |
| `+`    | One or more occurrences of the previous character. | `bi+t` matches words containing `b` followed by one or more `i` and then `t`. |
| `?`    | Zero or one occurrence of the previous character. | `bi?t` matches words containing `b` followed by zero or one `i` and then `t`. |
| `n\{n\}` | Matches exactly `n` occurrences of the previous character. | `ban{2}t` matches words containing `ba` followed by two `n` and then `t`. |
| `.`    | Matches any single character. | `b.t` matches words containing `b` followed by any character and then `t`. |
| `|`    | Either option. | `root \| bin` matches lines containing either `root` or `bin`. |

###### Examples

| Command | Description |
|---------|-------------|
| `grep '^g' myfile` | Matches lines starting with `g`. |
| `grep 'anna$' myfile` | Matches lines ending with `anna`. |
| `grep '\banna\b' myfile` | Matches lines containing the word `anna`. |
| `grep 'n.*x' myfile` | Matches lines containing `n` followed by any character and then `x`. |
| `grep -E 'bi+t' myfile` | Matches words containing `b` followed by one or more `i` and then `t`. |
| `grep -E 'bi?t' myfile` | Matches words containing `b` followed by zero or one `i` and then `t`. |
| `grep 'ban{2}t' myfile` | Matches words containing `ba` followed by two `n` and then `t`. |
| `grep 'b.t' myfile` | Matches words containing `b` followed by any character and then `t`. |
| `grep '^.$' myfile` | Matches lines containing only one character. |
| `grep -E '(root \| bin)' myfile` | Matches lines containing either `root` or `bin`. |

##### Using `tr`
`tr` is a command-line utility used to translate characters.

###### Examples

| Command | Description |
|---------|-------------|
| `echo "hello" \| tr '[:lower:]' '[:upper:]'` | Convert lower case to upper case. |
| `echo "hello" \| tr [a-z] [A-Z]` | Convert lower case to upper case. |

##### Introduction to `awk`
`awk` is a powerful command-line utility used for pattern scanning and processing. It can be used as a scripting language.

###### Examples

| Command | Description |
|---------|-------------|
| `awk '{ print $0 }' /etc/passwd` | Print each line of the `/etc/passwd` file. |
| `awk -F : '{ print $1 }' /etc/passwd` | Print the first field of each line in the `/etc/passwd` file using `:` as the field separator. |
| `awk 'length($0) > 50' /etc/passwd` | Print lines longer than 50 characters in the `/etc/passwd` file. |
| `awk -F : '/USER/ { print $3 }' /etc/passwd` | Get the user ID of the user `USER` from the `/etc/passwd` file. |
| `grep USER /etc/passwd \| cut -d ':' -f 3` | Get the user ID of the user `USER` using `grep` and `cut`. |

##### Introduction to `sed`
`sed` is a command-line utility used to perform text transformations. It is a stream editor that allows you to edit files in non-visual mode.

###### Examples

| Command | Description |
|---------|-------------|
| `sed -n 5p /etc/passwd` | Print the 5th line of the `/etc/passwd` file. |
| `sed -i s/PRORALIN/USER/g /etc/passwd` | Replace all occurrences of `PRORALIN` with `USER` in the `/etc/passwd` file. |
| `sed -i -e '2d' /etc/passwd` | Delete the 2nd line of the `/etc/passwd` file. |
