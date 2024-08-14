# Essential File Management

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

## mv - Move files and directories
- ``mv /dir/myfile /mydirectory`` - will move the file to `/mydirectory` which is already created
- by using `.*` you can move all only hidden files and directories.
- Use flags for more control over the move operation. Read the useful flags section below for more information.

## rm - Remove files or directories
- ``rm /dir/myfile`` - will remove the file
- ``rm -r /dir`` - will remove the directory and all its contents
- By using ``.*`` you can remove all only hidden files and directories. You should however see to not delete . and .. directories and you would also get this error probably: refusing to remove '.' or '..' directory: skipping '.' or '..' while using directory and recursive flags or rm: cannot remove '.': Is a directory without using the flags.
- 
- Use flags for more control over the remove operation. Read the useful flags section below for more information.

## Relative and Absolute Paths

- **Relative Path** - path relative to the current directory
  - e.g. `cd /var/log` - will change the directory to `/var/log`
  - e.g. `cd ..` - will change the directory to the parent directory
  - e.g. `cd ../..` - will change the directory to the parent of the parent directory
  - e.g. `cd ~` - will change the directory to the home directory
  - e.g. `cd -` - will change the directory to the previous directory
- **Absolute Path** - path relative to the root directory
  - e.g. `cd /var/log` - will change the directory to `/var/log`
  - e.g. `cd /` - will change the directory to the root directory 
  - e.g. `cd /root` - will change the directory to the root user home directory
  
  - Example:
     - make directory in /etc/ called tmp and in it make test directory, do the same in /home/ as well
  ```bash
  sudo mkdir -p /etc/tmp/test && sudo mkdir -p /home/tmp/test
  ```
  - change directory to home/tmp/test and make three files in the test directory of etc
  ```bash
  cd /home/tmp/test
  sudo touch /etc/tmp/test/file_{1..3}.txt 
  ```
  - with relative paths. copy the files form /etc/tmp/test to /home/tmp/test and then copy file_1.txt and file_2.txt to /home/{user}/Documents. Then move the third file to /home/{user}/Public. Then remove everything in /etc/tmp/test and /home/tmp/test Repeat the same with absolute paths
      - with relative paths
        ```bash
        # in directory /home/tmp/test

        # copy files from /etc/tmp/test to /home/tmp/test -> . is the current directory
        sudo cp /etc/tmp/test/file_{1..3}.txt .

        # copy file_1.txt and file_2.txt to /home/{user}/Documents ../.. is the parent of the parent directory
        sudo cp file_{1..2}.txt ../../{user}/Documents

        # move file_3.txt to /home/{user}/Public
        sudo mv file_3.txt ../../{user}/Public

        # this will remove the files in /etc/tmp/test and /home/tmp/test. * is used to remove all files in the directory -rf is used recursively and forcefully
        sudo rm -rf /etc/tmp/test/* && sudo rm -rf /home/tmp/test/*

        # Now we should delete the directories. we go back to home and then delete the directories with its parent directories with -p flag 
        # p flag is used to remove parent directories if they are empty 
        cd ../..
        sudo rmdir -p tmp/test &6 sudo rmdir /etc/tmp/test /etc/tmp
        ```
### Useful flags

##### Note
- you can mix flags together like `cp -rfv /dir /mydirectory` to copy the directory `/dir` to `/mydirectory` recursively and forcefully and verbosely

#### ***cp*** - Copy files and directories
- `-a` or `--archive` - same as `-dR --preserve=all` --> *hint: use ``tar`` utility to copy and archive hidden files rather than using `cp` command*
- `-b` or `--backup` - make a backup of each existing destination file
- `-f` or `--force` - remove without confirmation and asking questions
- `-r` or `--recursive` - copy directories recursively
- `-p` or `--preserve` - preserve the specified attributes
- `-v` or `--verbose` - explain what is being done

#### ***mv*** - Move files and directories
 - `-b` or `--backup` - make a backup of each existing destination file
 - `-f` or `--force` - remove without confirmation and asking questions
 - `-v` or `--verbose` - explain what is being done
 - `-i` or `--interactive` - prompt before overwriting	
 - `-u` or `--update` - move when the source is newer than the destination

#### ***rm*** - Remove files or directories
- `-r` or `--recursive` - remove directories and their contents recursively
- `-f` or `--force` - ignore nonexistent files and arguments, never prompt
- `-v` or `--verbose` - explain what is being done
- `-i` or `--interactive` - prompt before every removal or `-I` for less intrusive version of `-i`
- `-d` or `--dir` - remove empty directories

#### ***rmdir*** - Remove empty directories
- `-p` or `--parents` - remove parent directories if they are empty
- `-v` or `--verbose` - explain what is being done

#### ***mkdir*** - Make directories
- `-p` or `--parents` - no error if existing, make parent directories as needed
- `-v` or `--verbose` - explain what is being done

 
