## Advanced File Management
In this section, we will learn about hard links and symbolic links, searching files and directories, archiving and compression, and mounting and filesystems. We will also review the section and provide a cheat sheet for quick reference.

### TL;DR
#### Hard links and Symbolic Links
| Command | Description | Example |
| --- | --- | --- |
| `ln` | create a hard link to a file `ln <target> <link_name>` | `ln hosts hosts_hardlink` |
| `ln -s` | create a symbolic link to a file `ln -s <target> <link_name>` | `ln -s hosts hosts_symlink` |
| `ls -li` | list files with inode number | `ls -li hosts hosts_hardlink hosts_symlink` |
#### Searching files and directories
##### `find`
| Command | Description |
|---------|-------------|
| `find /path/to/search -user username` | Find files owned by a specific user. |
| `find /path/to/search -name "filename"` | Find files by name. |
| `find /path/to/search -size +1M` | size-based. Find files larger than 1MB in the path |
| `find /path/to/search -perm /4000` | permission based. Find files with setuid permission. |
###### Advanced Usage of `find`

| Command | Description | Options Used |
|---------|-------------|--------------|
| `mkdir /tmp/test ; sudo find /home -size +2M -exec cp {} /tmp/test \;` | Create a directory `/tmp/test`, find files larger than 2MB in `/home`, and copy them to `/tmp/test`. | `-exec` |
| `sudo find / -type f -size +5M` | Find files larger than 5MB in the root directory, only searching for files. | Combination of `-type` and `-size` |
| `sudo find /etc -type f -exec grep -l "root" {} \;` | Find files in `/etc` containing the string "root". | Using `grep` with `find` |
| `sudo find /etc/ -name '*.conf' -type f -exec cp {} /tmp/test \;` | Find files in `/etc` ending with `.conf` and copy them to `/tmp/test`. | Using wildcards with `find` and `-exec` option |
| `sudo find /etc/ -name '*' -type f \| xargs grep "127.0.0.1" 2>/dev/null` | Find files in `/etc` and search for "127.0.0.1" within them, suppressing error messages. | Using `xargs` with `grep`, ignoring errors with `2>/dev/null` |
##### Others
| Command | Description |
|---------|-------------|
| `which` | Find the location of a command. |
| `locate` | Find files by name. |
| `updatedb` | Update the database used by `locate`. |

#### Archiving and Compression
##### compression utilities
| Command | Description |
|---------|-------------|
| `gzip` | Compress files. Fast but not the best compression |
|`bzip2` | Compress files. Slower but better compression |
| `xzip` | Compress files. Slowest but best compression |
##### `tar` Command cheat sheet
| Option | Description | Command |
|--------|-------------|---------|
| -cjvf | Create a new archive with bzip2 compression | `tar -cjvf archive.tar.bz2 file1 file2 file3` |
| -xjvf | Extract files from an archive with bzip2 compression | `tar -xjvf archive.tar.bz2` |
| -cJvf | Create a new archive with xzip compression | `tar -cJvf archive.tar.xz file1 file2 file3` |
| -xJf | Extract files from an archive with xzip compression | `tar -xJf archive.tar.xz` |
| --exclude | Exclude files and directories | `tar -cvf /tmp/archive.tar /home --exclude=/home/user/temp` |
| -rvf | Append files to an existing archive | `tar -rvf /tmp/archive.tar /home/user/test` |
| -dvf | Verify the archive | `tar -dvf /tmp/archive.tar` |
| --wildcards | Use wildcards | `tar -cvf archive.tar /home/*.txt` |
| -cvpf | Preserve permissions | `tar -cvpf archive.tar /home` |
| split | Split the archive | `tar -cvf - /home \| split -b 100M - /tmp/backup.tar.part_` |
| -g snapshot.file (or any other name like sn.snar) | Create a snapshot file | `tar -cvJf full-backup.tar.xz -g snapshot.file  /etc` |
| -uvf | Update the archive | `tar -uvf /tmp/full-backup.tar /etc` |
#### Mounting and Filesystems
| Command | Description |
|---------|-------------|
| `lsblk` | List all block devices. |
| `sudo umount /dev/<device-name>` | Unmount a device. |
| `sudo umount /path/to/mountpoint` | Unmount a device by specifying the mount point. |
|`sudo mkdir /path/to/mountpoint && sudo mount /dev/<device-name> /path/to/mountpoint` | Create a mount point and mount a device to a specific mount point. |
| `df -h` | Display disk space usage. Human-readable format |
| `findmnt` | Display mounted filesystems. Detailed |
| `mount` | List all current mounts. |

