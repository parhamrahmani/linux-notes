# Essential File Management

## Linux Filesystem
- **/** - root directory
- **/usr** - User programs
- **/var** - Variable files
  - e.g. /var/log - Log files 
- **/etc** - Text Based Configuration files
  - e.g. /etc/passwd - User account information
- **/bin** - Essential user command binaries
  - nowadays, /bin and /sbin are symbolic links to /usr/bin and /usr/sbin 
- **/boot** - Boot loader files
- **/dev** - Device files
  - e.g. /etc/sda -> primary hard drive/disk  
- **/home** - Home directories
- **/lib** & **/lib64** - Shared libraries
  - lib and lib64 are symbolic links to /usr/lib and /usr/lib64
- **/media** - Removable media
  - e.g. /media/cdrom - CD-ROM mount point
  - e.g. /media/usb - USB drive mount point
- **/mnt** - Mount point for mounting filesystems
- **/opt** - Add-on application software packages
- **/sbin** - Essential system command binaries
- **/srv** - Service data
- **/tmp** - Temporary files
- **/proc** - Kernel and process information
- **/root** - Root user home directory
  - need to do `sudo su` to chnage user and access root user home directory
- **/sys** - Kernel and system information
- **/usr/local** - Local hierarchy for locally installed software
### man hier 
- `man hier` will display the filesystem hierarchy standard.

## USing Wildcards

- `ls a*` - will list all files that start with `a`
- `ls a?*` - will list all files that start with `a` and have at least one character after `a`
- `ls a[bc]*` - will list all files that start with `a` and have `b` or `c` as the second character
- `ls a[^bc]*` - will list all files that start with `a` and have any character other than `b` or `c` as the second character
- `ls a[a-e]*` - will list all files that start with `a` and have `a`, `b`, `c`, `d`, or `e` as the second character
- `touch a{1..5}` - will create files `a1`, `a2`, `a3`, `a4`, and `a5`
- `mkdir /data/{sales,marketing,hr}` - will create directories `sales`, `marketing`, and `hr` in `/data` directory
  - if data directory doesn't exist, it will give an error. so if it doesn't exist
  -> `sudo mkdir -p /data/{sales,marketing,hr}` to create the directories. -p flag is used to create parent directories if they don't exist.
  - `ls /data` will list the directories `sales`, `marketing`, and `hr`. 
- `ls -d [ab]????` - will list all files that start with `a` or `b` and have 4 characters after `a` or `b`
  - e.g. on /var/log directory, `ls -d [ab]???` will list all files that start with `a` or `b` and have 3 characters after `a` or `b` 
and we get `btmp` 
- `touch file_{1..5}.txt` - will create files `file_1.txt`, `file_2.txt`, `file_3.txt`, `file_4.txt`, and `file_5.txt`
- ```rm file_{1..5}.txt``` - will remove files `file_1.txt`, `file_2.txt`, `file_3.txt`, `file_4.txt`, and `file_5.txt`

## cp - Copy files and directories
- ``cp /dir/myfile /mydirectory`` - will copy the file to `/mydirectory` which is already created
- ``cp -a ~/.* /tmp/`` - will copy all hidden files and directories from the home directory to `/tmp/` directory
- use ``tar`` utility to copy and archive hidden files rather than using `cp` command
- ``cp -r /dir /mydirectory`` - will copy the directory to `/mydirectory` which is already created and will include all subdirectories and files
why? because of -r which means recursive
- e.g. ``cp /etc/passwd /home/.userdata/`` will copy the passwd file to the .userdata directory in the home directory
