### Example of Advanced File Management
#### Description
- Find all ***files*** in `/etc` that have a smaller size than ***1000 bytes*** and copy them to `/tmp/files/pictures`
- In `tmp/files` directory, create a symbolic link to `/var`
- Create a xzip compressed archive of `/home` directory and save it to `/tmp`
- extract the archive to `tmp/archive`

------------------------------------------------------------------------------
#### Solution
- ###### make the directories
```bash
sudo mkdir -p /tmp/files/pictures /tmp/home /tmp/archive
```

- ###### find ***files*** in `/etc` that have a size less than 1000 bytes and copy them to `/tmp/files/pictures`
```bash
sudo find /etc -type f -size -1000c -exec cp {} /tmp/files/pictures \;
```
use `c` for bytes, `k` for kilobytes, `M` for megabytes, `G` for gigabytes, etc.
- ###### check if the files are copied
```bash
ls -la /tmp/files/pictures
```
- ###### create a symbolic link to `/var` in `/tmp/files`
```bash
sudo ln -s /var /tmp/files/symlinktovar
```
`ln -s <target> <link-name>`
- ###### let's check if the symbolic link is created
```bash
ls -la /tmp/files
```
```
total 12
 6641 drwxr-xr-x 3 USER USER 4096 Aug 29 13:33 .
57346 drwxrwxrwt 6 root root 4096 Aug 29 13:32 ..
23286 drwxr-xr-x 2 USER USER 4096 Aug 29 13:17 pictures
23449 lrwxrwxrwx 1 root root    4 Aug 29 13:33 symlinktovar -> /var
```
- ###### create a xzip compressed archive of `/home` directory and save it to `/tmp`
```bash
sudo tar -cvJf /tmp/homebackup.tar.xz /home 
```
- ###### let's check if the archive is created
```bash
ls -la /tmp
```
```bash
total 12812
drwxrwxrwt  6 root root     4096 Aug 29 13:47 .
drwxr-xr-x 19 root root     4096 Aug 29 13:46 ..
drwxr-xr-x  2 USER USER     4096 Aug 29 13:15 archive
drwxr-xr-x  3 USER USER     4096 Aug 29 13:33 files
-rw-r--r--  1 root root 13095308 Aug 29 13:47 homebackup.tar.xz
drwxrwxrwx  2 root root       60 Aug 29 10:53 .X11-unix
```	
- ###### extract the archive to `tmp/archive`
```bash
sudo tar -xJf /tmp/homebackup.tar.xz -C tmp/archive
```
- ###### check if the archive is extracted
```bash
ls -la /tmp/archive
```
```bash
total 12
drwxr-xr-x 3 USER USER 4096 Aug 29 13:55 .
drwxrwxrwt 6 root root 4096 Aug 29 13:47 ..
drwxr-xr-x 4 root root 4096 Aug 28 15:20 home
```
- ###### Remove the files and directories created
```bash
sudo rm -rf /tmp/files /tmp/home /tmp/archive
```
  