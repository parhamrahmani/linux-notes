# Archiving and Compressing in Linux

## Archiving with `tar`

### Basic Usage
- `tar` is a command line utility that is used to create compressed archives of files and directories.

    - archving files
        ```bash
        tar -cvf archive.tar file1 file2 file3
        ```
    - archiving directories
        ```bash
        tar -cvf archive.tar directory1 directory2 directory3
        ```
    - extracting files
        ```bash
        tar -xvf archive.tar
        ```
    - extracting files to a specific directory
        ```bash
        tar -xvf archive.tar -C /path/to/directory
        ```
    - extracting specific files
        ```bash
        tar -xvf archive.tar file1 file2 file3
        ```
    - seee the contents of an archive
        ```bash
        tar -tvf archive.tar
        ```
#### Example
- Create an archive of /etc and /home directories into a file called `backup.tar`. put the archive in /tmp directory.
    ```bash
    tar -cvf /tmp/backup.tar /etc /home
    ```

### Compression with `gzip`, `bzip2`, `xzip`
Firstly we archive the files and directories and then compress the archive file. We can use the following options to compress the archive file.

| Option | Pros and Cons | Usage | Example Compression | Example Extraction |	
| --- |  --- | --- | --- | --- |
| `gzip` | faster but less compression | use `-z` | `tar -czvf /tmp/backup.tar.gz /home/testuser`| `tar -xzvf /tmp/backup.tar.gz` |
| `bzip2` | slower but more compression | use `-j` | `tar -cjvf /tmp/backup.tar.bz2 /home/testuser` | `tar -xjvf /tmp/backup.tar.bz2` |
| `xzip` | slowest but best compression | use `-J` | `tar -cJvf /tmp/backup.tar.xz /home/testuser` | `tar -xJvf /tmp/backup.tar.xz` |


### Other Features and Options

- ##### Exclude files and directories
    ```bash
    tar -cvf /tmp/archive.tar /home --exclude=/home/user/temp
    ```
- ##### Append files to an existing archive
    ```bash
    tar -rvf /tmp/archive.tar /etc/hosts
    ```
- ##### Verifying the archive
    ```bash
    tar -dvf /tmp/archive.tar
    ```
- ##### Using wildcards
    ```bash
    tar -cvf archive.tar /home/*.txt
    ```
    - example: extract all conf and txt files from the xz archive
        ```bash
        tar -xJvf archive.tar.xz --wildcards '*.conf' '*.txt'
        ```
- ##### Preserve permissions
    ```bash
    tar -cvpf archive.tar /home
    ```
- ##### Splitting the archive
    ```bash
    sudo tar -cJ /etc | split -b 10M - /home/test/backup/backup.tar.xz.part_
    ```
    `-b` option is used to specify the size of the split files. In this case, the archive will be split into 10M files. The `-` is used to specify the input file. The last argument is the prefix of the split files. The split files will be named as `backup.tar.xz.part_aa`, `backup.tar.xz.part_ab`, etc.	

    - you can also do it better like this:
        ```bash
        sudo tar -cJ /etc | split --verbose -b 1M --numeric-suffixes=1 - /home/test/backup/backup.tar.xz.part_
        ```
        - `--verbose` is used to show the progress of the split operation.
        - `--numeric-suffixes=1` is used to start the suffix with 1. The default is 2.
        - `-` is used to specify the input file.
        - the last argument is the prefix of the split files. The split files will be named as `backup.tar.xz.part_1`, `backup.tar.xz.part_2`, etc.
        - the split files will be 1M in size.
        - the split files will be created in the `/home/test/backup/` directory.
          ###### Example output
          ```bash
           test@test/backup > sudo tar -cJ /etc | split --verbose -b 100K --numeric-suffixes=1 - /home/test/backup/backup.tar.xz.part_
            tar: Removing leading `/' from member names
            creating file '/home/test/backup/backup.tar.xz.part_01'
            creating file '/home/test/backup/backup.tar.xz.part_02'
            creating file '/home/test/backup/backup.tar.xz.part_03'
            creating file '/home/test/backup/backup.tar.xz.part_04'
          ```
##### Incremental backups
Let's make an initial full backup of the /etc directory.
```bash
sudo tar -cvJf full-backup.tar.xz -g snapshot.file /etc
```
`-g snapshot.file` means to create a snapshot file. This file will be used to create incremental backups. The snapshot file will contain the list of files and directories that are backed up. The snapshot file will be created in the current directory.

Then we can create incremental backups like this:
```bash
sudo tar -cvJf incremental-backup.tar.xz -g snapshot.file /etc
```
This will create an incremental backup of the /etc directory. The snapshot file will be used to compare the files and directories that are changed since the last backup. The incremental backup will contain only the changed files and directories.

##### Update a compressed archive (without creating a snapshot file)
Let's make a full backup of the /etc directory (without creating a snapshot file).

```bash	
sudo tar -cvJf full-backup.tar.xz /etc
```
Then we can update the archive like this:
- extract the archive
    ```bash
    tar -xJf /home/user/full-backup.tar.xz -C /tmp
    ```
- update the archive
    ```bash
    tar -uvf /tmp/full-backup.tar /etc
    ```
    - `u` option is used to update the archive. The files that are changed since the last backup will be added to the archive. The archive will be updated with the new files and directories.
-  re-compress the archive and delete the temporary updated archive
    ```bash
    XZ_OPT=-9 tar -cJf /home/user/full-backup.tar.xz -C /tmp full-backup.tar && rm /tmp/full-backup.tar
    ```
    - `XZ_OPT=-9`: This sets an environment variable for xz compression, specifying the highest compression level (9).
    - `tar -cJf /path/to/full-backup.tar.xz`:
      - `-c`: Create a new archive
      - `-J`: Use xz compression
      - `-f /home/user/full-backup.tar.xz`: Specify the output file
    - `-C /tmp`: Change to the /tmp directory before performing operations
    - `full-backup.tar`: This is the input file to be compressed
    - `&& rm /tmp/full-backup.tar`: After successful compression, remove the temporary uncompressed file

    **or**
    ```bash
    xz -9 -c /tmp/full-backup.tar > /home/user/full-backup.tar.xz && rm /tmp/full-backup.tar
    ```
    - This compresses the updated tar file to its original location using xz directly, then removes the temporary uncompressed file.
    - XZ_OPT=-9 or -9 is used to set the compression level to 9. The default is 6. The higher the number, the better the compression but slower the process. The compression level can be set from 0 to 9.
##### timing the compression
Use the `time` command to time the compression process. This will show the time taken to compress the archive.
```bash
time tar -cJf /tmp/full-backup.tar.xz /etc
```

            
### `tar` Cheat Sheet
| Option | Description | Command |
|--------|-------------|---------|
| -cjvf | Create a new archive with bzip2 compression | `tar -cjvf archive.tar.bz2 file1 file2 file3` |
| -xjvf | Extract files from an archive with bzip2 compression | `tar -xjvf archive.tar.bz2` |
| -cJvf | Create a new archive with xzip compression | `tar -cJvf archive.tar.xz file1 file2 file3` |
| -xJvf | Extract files from an archive with xzip compression | `tar -xJvf archive.tar.xz` |
| --exclude | Exclude files and directories | `tar -cvf /tmp/archive.tar /home --exclude=/home/user/temp` |
| -rvf | Append files to an existing archive | `tar -rvf /tmp/archive.tar /home/user/test` |
| -dvf | Verify the archive | `tar -dvf /tmp/archive.tar` |
| --wildcards | Use wildcards | `tar -cvf archive.tar /home/*.txt` |
| -cvpf | Preserve permissions | `tar -cvpf archive.tar /home` |
| split | Split the archive | `tar -cvf - /home \| split -b 100M - /tmp/backup.tar.part_` |
| -g snapshot.file (or any other name like sn.snar) | Create a snapshot file | `tar -cvJf full-backup.tar.xz -g snapshot.file  /etc` |
| -uvf | Update the archive | `tar -uvf /tmp/full-backup.tar /etc` |

