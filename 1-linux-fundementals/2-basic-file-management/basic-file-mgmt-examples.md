### Example task for a basic file managment task


1. Create directories `/home/tmp/files/first`, `/home/tmp/files/second`, and `/home/tmp/files/third` and a hidden folder in `/home/tmp/files/` called `hidden-files`.
2. Create a hidden directory in /etc/ called temporary and create 100 hidden files with it like this file1.txt ---> file100.txt.  
3. Copy any files from `/etc` to `/home/tmp/files` that start with letters t and in range of a to e. 
4. Copy the files starting with t and c to `/home/tmp/files/first`, files starting with a and b to `/home/tmp/files/second`, and files starting with d and e to `/home/tmp/files/third`.
5. Copy all hidden files from `/etc/.temporary` to `/home/tmp/files/hidden-files`.
6. Remove all files from `/home/tmp/files` that are already copied to their respective directories.
7. Remove everything existing in /home/tmp/files and then remove the directories as well.


### Solution

##### 1 & 2. Create directories
```bash
# using mkdir -p to create parent directories if they don't exist
# using wildcard to create multiple directories in one command
# using . to create a hidden directory called hidden-files
sudo mkdir -p /home/tmp/files/{first,second,third,.hidden-files}
# Create a hidden directory in /etc called temporary and create 100 hidden files with it like this file1.txt ---> file100.txt.
sudo mkdir -p /etc/.temporary && sudo touch /etc/.temporary/.file{1..100}.txt
```
##### 3. Copy files from `/etc` to `/home/tmp/files` that starts with start with letters t and in range of a to e. 
```bash
# The -r option ensures that directories are copied recursively. This command will copy both files and directories that match the specified pattern.
sudo cp -r /etc/[a-e,t]* /home/tmp/files
# Copy all hidden files from /etc/.temporary to /home/tmp/files/hidden-files
# Remember we shouldn't copy . and .. directories. 
# We can use [!.]* to exclude . and .. directories
sudo cp -r /etc/.temporary/.[!.]* /home/tmp/files/.hidden-files

```
##### 4 & 5. Copy files to respective directories
```bash
# Copy files starting with t and c to /home/tmp/files/first
sudo cp -r /home/tmp/files/[c,t]* /home/tmp/files/first
# Copy files starting with a and b to /home/tmp/files/second
sudo cp -r /home/tmp/files/[a,b]* /home/tmp/files/second
# Copy files starting with d and e to /home/tmp/files/third
sudo cp -r /home/tmp/files/[d,e]* /home/tmp/files/third
# Copy all hidden files from /etc to /home/tmp/files/hidden-files
```

##### 6. Remove all files from `/home/tmp/files` that are already copied to their respective directories.
```bash
# Remove all files from /home/tmp/files that are already copied to their respective directories and remember to exclude . and .. directories
sudo rm -rf /home/tmp/files/[a-e,t]* /home/tmp/files/.[!.]*
```
##### 7. Remove everything existing in /home/tmp/files and then remove the directories as well.
```bash
# remove every files and directories in /home/tmp/files and also the hidden files and directories excluding . and ..    
# -rdf is used to remove directories recursively and forcefully
sudo rm -rdf /home/tmp/files/* && sudo rm -rdf /home/tmp/files/.[!.]*
# now we have /tmp and /tmp/files directories. we can remove them as well
sudo rmdir /home/tmp/files /home/tmp 
```