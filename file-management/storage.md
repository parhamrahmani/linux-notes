# Storage in Linux
## Introduction
The storage in a Linux server maybe internal or external. The internal storage is the hard disk that is attached to the server. The external storage is thtough SAN (Storage Area Network) or NAS (Network Attached Storage) is connected to the server through the network. 

We address disks using the **``/dev``** directory. The disks are named as **``/dev/sda``**, **``/dev/sdb``**, **``/dev/sdc``** and so on. The partitions on the disks are named as **``/dev/sda1``**, **``/dev/sda2``**, **``/dev/sdb1``**, **``/dev/sdb2``** and so on.

- **``/dev/sda``** : First SCSI disk and then ``/dev/sdb`` is the second SCSI disk and so on.
- **``/dev/vda``** : First virtual disk (KVM hard disk) and then ``/dev/vdb`` is the second virtual disk and so on.
- **``/dev/nvme0n1``** : First NVMe disk and then ``/dev/nvme1n1`` is the second NVMe disk and so on.
- **``/dev/sr0``** : First CD/DVD drive (optical drive) and then ``/dev/sr1`` is the second CD/DVD drive and so on.
  

### External Storage
#### NAS (Network Attached Storage) and SAN (Storage Area Network)
![NAS vs SAN](san.drawio.png)
#### NAS (Network Attached Storage)

NAS is a centralized storage device on a netwrok that can be accessed by the devices on that network. It basically shares a pool of storage between an entire network of devices. 

It has multiple hard drives that are configured in a RAID (Redundant Array of Independent Disks) configuration. The RAID configuration provides redundancy and fault tolerance. [RAID](https://www.howtogeek.com/162676/how-to-use-multiple-disks-intelligently-an-introduction-to-raid/)

#### SAN (Storage Area Network) 
A storage area network is a **high-speed dedicated network** of disks that is accessed by a server or a network of servers and **interconnected by hosts, switches and storage devices**, a SAN makes storage devices accessible to multiple servers. In SAN raw storage is treated as pool of resources that can be centrally managed and allocated to servers as needed. 

most organizations employ some form of SAN in addition to network-attached storage (NAS) for improved efficiency and better data management. Traditionally, only a limited number of storage devices could attach to a server, limiting a network's storage capacity. **However, a SAN introduces networking flexibility that enables one server, or many heterogeneous servers across multiple data centers, to share a common storage utility.**

*Useful Sources:*
- [*SAN - TechTarget*](https://www.techtarget.com/searchstorage/definition/storage-area-network-SAN)
- [*SAN - IBM*](https://www.ibm.com/topics/storage-area-network)

### Linux Partitions 
[Useful Source](https://www.linuxfordevices.com/tutorials/linux/partitions-and-filesystems)
A partition is a segment of a drive that is *logically* separated from the rest of the drive. Partitions are used to organize the data on a hard drive.

![Partitions](LinuxPartitions.jpeg)

- **boot** : Contains the boot loader and kenrnel files for booting the system.
- **root** : Contains the root file system and practically where the operating system is installed.
- **swap** : Contains the swap space and acts as a overflow for the RAM when it is full.
- **home** : Contains the user's personal files and other data.

#### File Systems
A file system is how the data is managed on the partition. The file system is responsible for indexing, storing, naming and retrieving the data on the partition.
##### Common File Systems
- **``FAT32``** : File Allocation Table 32-bit. It is an older file system and the maximum file size allowed in FAT32 is 4Gb.
- **``NTFS``** : New Technology File System. It is a file system that is used in **Windows** operating systems. It is supporting drive sizes of up to 16 exabytes (more than 17 billion gigabytes) and individual file sizes of 256TB. 
    - **journaling system**: means that NTFS stores the logs of all the changes committed on the device. This makes it easy to revert back to a previous version of the filesystem if anything breaks or crashes. 
- **``ext4``** : Extended File System 4. It is the default file system for most **Linux** distributions. It is a journaling file system and is the fourth extended file system. **ext4** is the most recent version of the extended file system family. It supports volumes with sizes up to 1 exabyte and single files with sizes up to 16 terabytes
    - **delayed allocation**: allocates the sectors to the file when they are forcefully flushed to the storage. This improves CPU performance and less bad sectors

- **``XFS``**: XFS is a high-performance 64-bit journaling file system created by Silicon Graphics, Inc (SGI) in 1993. It is the default file system for **Red Hat Enterprise Linux**. . It supports file systems up to 16 exabytes and files up to 8 exabytes. It is a journaling file system, which means that it keeps a log of changes that are going to be made to the file system. This makes it easier to recover from crashes and power failures. XFS is a good choice for large storage systems and high-performance computing environments.

- **``ZFS``** : Advanced file system used in **FreeBSD** and **Linux**.  
    - disk pooling (pooling different storage devices to make them work as one)
   - copy-on-write (copying data to a different sector before overwriting it)
   - Snapshots (keeping track of all file changes)
   - Data integrity verification (verifying checksums of files to verify if they have been corrupted or not)
   - RAID-Z (Data redundancy to make storage more reliable).

- **``Btrfs``** : B-tree file system developed by Oracle on ext4. It includes data pooling, copy-on-write, Snapshots, and RAID very smilar to ZFS. It also offers online defragmentation. Perfect for laprops and alsp production servers. OpenSUSE uses Btrfs as the default file system.
###### ``Swapfs`` , ``Initramfs`` and ``vfat``
- **``swapfs``** : A swap file system is a dedicated partition or a file that is used to store the data that is not being used by the RAM. It is used as a temporary storage space for data that is not being used by the RAM. 
- **``initramfs``** : The initial RAM file system is a temporary file system that is used to load the kernel and the initial RAM disk into memory so that the system can boot up.
- **``vfat``** : Virtual File Allocation Table. It is a file system that is only used and seen in **boot** partitions. Since it is readable and writable by both Windows and Linux. If the system is using UEFI, the boot partition must be formatted as vfat. This is rarely seen in complete linux systems and more common in dual boot systems or WSL.

#### ``mkfs`` Utility
- ``mkfs`` is a command-line utility that is used to format a disk with a file system.
- ``mkfs`` is followed by the file system type and the disk that is to be formatted.
- ``mkfs`` is used to format the disk with a file system. 
```bash
sudo mkfs.<file system> <disk>
```
#### Quick Example
We have a 500 GB disk and we want to partition it. We want boot,root and home (no swap). We will use ext4 file system.
The partitioning will be as follows:
- **boot** : 512 MB
- **root** : 100 GB
- **home** : 346.6 GB
Use to list the block devices and their partitions and file systems. 
```bash
lsblk
```

### LVM (Logical Volume Manager)
- [Useful Source](https://linuxhandbook.com/lvm-guide/)
- [Useful Source](https://itsfoss.com/lvm-guide/)
LVM is a mechanism to manage storage systems.  In LVM, instead of creating partitions, you create logical volumes, and then you can just as easily mount those volumes in your filesystem as you'd a disk partition.
***NOTE: you can not use logical volumes for /boot. That is because GRUB (the most common bootloader for Linux) can't read from logical volumes. The well-known alternative to GRUB, systemd-boot on the other hand reads only vfat filesystems, so that's not going to work either.***	
#### LVM Components
- **Physical Volume (PV)** : A physical volume is a hard drive or partition that is used to create a volume group.
- **Volume Group (VG)** : A volume group is a collection of physical volumes. You can think of it as a pool of storage.
- **Logical Volume (LV)** : A logical volume is a virtual partition that is created from a volume group. You can think of it as a partition that is created from a pool of storage.
- Physical Extent (PE): Smallest units of storage in a PV.
- Logical Extent (LE): Similar to PEs, but within LVs.
- Metadata: Information describing the configuration of PVs, VGs, and LVs.

|Disk Partitioning System|	LVM|
|------------------------|----|
|Partitions|	Logical Volumes|
|Disks	|Volume Groups|

With LVM it is easier to resize the partitions. This makes LVM a scalable solution for storage management.

## Partitioning
### MBR (Master Boot Record)
- old and outdated solution for partitioning and addressing storage devices and disks.
- maximum of 4 primary partitions can be written to the 512 bytes boot sector.
- to address more than 4 partitions, one of the primary partitions can be converted to an extended partition. The extended partition can have multiple logical partitions. the first logical partition is addressed as the 5th partition.

#### ``fdisk`` Utility
- ``fdisk`` is a command-line utility that provides disk partitioning functions in MBR. 
### GPT (GUID Partition Table)
- GPT is a newer partitioning standard that is gradually replacing MBR.
- A maximum of 128 partitions can be created in GPT.
- is required for disks larger than 2TB.
#### ``gdisk`` Utility
- ``gdisk`` is a command-line utility that provides disk partitioning functions in GPT.
- ``gdisk`` is a variant of ``fdisk`` that is used for GPT partitioning.

## Mounting
- Mounting is the process of attaching a storage device to the file system. After it was partitioned and formatted, it can be mounted to the file system.
- The mount point is the directory where the storage device is attached to the file system.
- CD/DVD and flash drives are also required to be mounted to the file system.
### ``mount`` Utility
- ``mount`` is a command-line utility that is used to mount a storage device to the file system.
- ``mount`` is followed by the storage device and the mount point.
```bash
sudo mount <storage device> <mount point>
```
### ``umount`` Utility
- ``umount`` is a command-line utility that is used to unmount a storage device from the file system.
- ``umount`` is followed by the mount point.
```bash
sudo umount <mount point>
```

## Comprehensive Demo
In Linux w to use disks, we should first paritition them, then format them with a file system and finally mount them.
The following is a comprehensive demo on how to partition, format and mount a disk in Linux.

### Partitioning a Disk
#### Master Boot Record (MBR)
- list the block devices and their partitions and file systems. 
```bash
lsblk
```
```
NAME         MAJ:MIN     RM   SIZE  RO  TYPE MOUNTPOINTS
sda            8:0        0    20G   0  disk
├─sda1         8:1        0     1G   0  part /boot
├─sda2         8:2        0    19G   0  part 
   └─cs-root 253:0        0    17G   0  lvm  /
   └─cs-swap 253:1        0     2G   0  lvm
sdb            8:16       0    20G   0  disk
sr0           11:0        1  1024M   0  rom  /run/media/USER/cenots-8.1.1911-x86_64-dvd
```
- let's create partitions on the disk **``sdb``**. we address the disk using device files in the ``/dev`` directory. 
```bash
sudo fdisk /dev/sdb
```
```
Welcome to fdisk (util-linux 2.36).
Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.

Device does not contain a recognized partition table.
Created a new DOS disklabel with disk identifier 0x760d3437.

Command (m for help): 
```
- press **``n``** to create a new partition. 
```
Command (m for help): n
Partition type
   p   primary (0 primary, 0 extended, 4 free)
   e   extended (container for logical partitions)
Select (default p):
```
- we have 4 free primary partitions. we can create a primary partition. let's choose number **``1``** for the partition number and 5 GB for the size. 
```
Using default response p.
Partition number (1-4, default 1): 1   
First sector (2048-41943039, default 2048):
Last sector, +/-sectors or +/-size{K,M,G,T,P} (2048-41943039, default 41943039): +5G
``` 
- press **``p``** to print the partition table and verify the changes. 
```
Command (m for help): p
Disk /dev/sdb: 20 GiB, 21474836480 bytes, 41943040 sectors
Disk model: VMware Virtual S
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x760d3437

Device     Boot Start      End  Sectors Size Id Type
/dev/sdb1        2048 10485759 10483712   5G 83 Linux
```
- finally press **``w``** to write the changes to the disk. 
```
Command (m for help): w
The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.
```
- list the block devices and their partitions and file systems. 
```bash
lsblk
```
```
NAME         MAJ:MIN    RM   SIZE  RO  TYPE MOUNTPOINTS
sda            8:0       0    20G   0  disk
├─sda1         8:1       0     1G   0  part /boot
├─sda2         8:2       0    19G   0  part 
   └─cs-root 253:0       0    17G   0  lvm  /
   └─cs-swap 253:1       0     2G   0  lvm
sdb            8:16      0    20G   0  disk
└─sdb1         8:17      0     5G   0  part
sr0           11:0       1  1024M   0  rom  /run/media/USER/cenots-8.1.1911-x86_64-dvd
```
#### GUID Partition Table (GPT) 
- we attach a 20 GB disk to the server and it is addressed as **``sdc``**.
- list the block devices and their partitions and file systems. 
```bash
lsblk
```
```
NAME         MAJ:MIN     RM   SIZE  RO  TYPE MOUNTPOINTS
sda            8:0        0    20G   0  disk
├─sda1         8:1        0     1G   0  part /boot
├─sda2         8:2        0    19G   0  part 
   └─cs-root 253:0        0    17G   0  lvm  /
   └─cs-swap 253:1        0     2G   0  lvm
sdb            8:16       0    20G   0  disk
└─sdb1         8:17       0     5G   0  part
sdc            8:32       0    20G   0  disk
sr0           11:0        1  1024M   0  rom  /run/media/USER/cenots-8.1.1911-x86_64-dvd
```
- let's create partitions on the disk **``sdc``**. we address the disk using device files in the ``/dev`` directory. 
```bash
sudo gdisk /dev/sdc
```
```
GPT fdisk (gdisk) version 1.0.5

Partition table scan:
  MBR: not present
  BSD: not present
  APM: not present
  GPT: not present

Creating new GPT entries in memory.
Command (? for help): 
```
- press **``n``** to create a new partition. we give it the whole disk size. 
```
Command (? for help): n
Partition number (1-128, default 1): 1
First sector (34-41943006, default = 2048) or {+-}size{KMGTP}:
Last sector (2048-41943006, default = 41943006) or {+-}size{KMGTP}: 
Current type is 8300 'Linux filesystem'
Hex code or GUID (L to show codes, Enter = 8300):
Changed type of partition to 'Linux filesystem'
```
- press **``p``** to print the partition table and verify the changes. 
```
Command (? for help): p
Disk /dev/sdc: 41943040 sectors, 20.0 GiB
Model: VMware Virtual S
Sector size (logical/physical): 512/512 bytes
Disk identifier (GUID): 3D3D3D3D-3D3D-3D3D-3D3D-3D3D3D3D3D3D
Partition table holds up to 128 entries
Main partition table begins at sector 2 and ends at sector 33
First usable sector is 34, last usable sector is 41943006
Partitions will be aligned on 2048-sector boundaries
Total free space is 41942973 sectors (20.0 GiB)

Number  Start (sector)    End (sector)  Size       Code  Name
   1            2048        41943006   20.0 GiB    8300  Linux filesystem
```
- finally press **``w``** to write the changes to the disk and press **``y``** to confirm.
```
Command (? for help): w

Final checks complete. About to write GPT data. THIS WILL OVERWRITE EXISTING
PARTITIONS!!

Do you want to proceed? (Y/N): y
OK; writing new GUID partition table (GPT) to /dev/sdc.
The operation has completed successfully.
```
- list the block devices and their partitions and file systems. 
```bash
lsblk
```
```
NAME         MAJ:MIN     RM   SIZE  RO  TYPE MOUNTPOINTS
sda            8:0        0    20G   0  disk
├─sda1         8:1        0     1G   0  part /boot
├─sda2         8:2        0    19G   0  part 
   └─cs-root 253:0        0    17G   0  lvm  /
   └─cs-swap 253:1        0     2G   0  lvm
sdb            8:16       0    20G   0  disk
└─sdb1         8:17       0     5G   0  part
sdc            8:32       0    20G   0  disk
└─sdc1         8:33       0    20G   0  part
sr0           11:0        1  1024M   0  rom  /run/media/USER/cenots-8.1.1911-x86_64-dvd
```
### Formatting a Disk
#### XFS File System
- let's format the partition **``sdb1``** with **``XFS``** file system. 
```bash
sudo mkfs.xfs /dev/sdb1
```
#### Ext4 File System
let's format the partition **``sdc1``** with **``ext4``** file system. 
```bash
sudo mkfs.ext4 /dev/sdc1
```
### Mounting a Disk
- we have partitioned and formatted the disk. Now we will mount the disks to the file system.

#### Mounting ``/dev/sdb1`` to ``/mnt/data/sdb1``
- create a directory **``data``** in the **``/mnt``** directory. 
```bash
sudo mkdir -p /mnt/data/sdb1
```
- mount the partition **``sdb1``** to the directory **``/mnt/data/sdb1``**. 
```bash
sudo mount /dev/sdb1 /mnt/data/sdb1
```
- list the block devices and their partitions and file systems. 
```bash
lsblk
```
```
NAME         MAJ:MIN     RM   SIZE  RO  TYPE MOUNTPOINTS
sda            8:0        0    20G   0  disk
├─sda1         8:1        0     1G   0  part /boot
├─sda2         8:2        0    19G   0  part 
   └─cs-root 253:0        0    17G   0  lvm  /
   └─cs-swap 253:1        0     2G   0  lvm
sdb            8:16       0    20G   0  disk
└─sdb1         8:17       0     5G   0  part /mnt/data/sdb1
sdc            8:32       0    20G   0  disk
└─sdc1         8:33       0    20G   0  part
sr0           11:0        1  1024M   0  rom  /run/media/USER/cenots-8.1.1911-x86_64-dvd
```
#### Mounting ``/dev/sdc1`` to ``/mnt/data/sdc1``
- create a directory **``data/sdc1``** in the **``/mnt``** directory. 
```bash
sudo mkdir -p /mnt/data/sdc1
```
- mount the partition **``sdc1``** to the directory **``/mnt/data/sdc1``**. 
```bash
sudo mount /dev/sdc1 /mnt/data/sdc1
```
- list the block devices and their partitions and file systems. 
```bash
lsblk
```
```
NAME         MAJ:MIN     RM   SIZE  RO  TYPE MOUNTPOINTS
sda            8:0        0    20G   0  disk
├─sda1         8:1        0     1G   0  part /boot
├─sda2         8:2        0    19G   0  part 
   └─cs-root 253:0        0    17G   0  lvm  /
   └─cs-swap 253:1        0     2G   0  lvm
sdb            8:16       0    20G   0  disk
└─sdb1         8:17       0     5G   0  part /mnt/data/sdb1
sdc            8:32       0    20G   0  disk
└─sdc1         8:33       0    20G   0  part /mnt/data/sdc1
sr0           11:0        1  1024M   0  rom  /run/media/USER/cenots-8.1.1911-x86_64-dvd
```
***Note: using ``/mnt`` directory is  a practice for temporary mounts. For persistent mounting see [here](#making-mounts-permanent)***
### Unmounting ``/dev/sdb1`` and ``/dev/sdc1``
- unmount the partition **``sdb1``** from the directory **``/mnt/data/sdb1``**. 
```bash
sudo umount /mnt/data/sdb1
```
- unmount the partition **``sdc1``** from the directory **``/mnt/data/sdc1``**. 
```bash
sudo umount /mnt/data/sdc1
```
- list the block devices and their partitions and file systems. 
```bash
lsblk
```
```
NAME         MAJ:MIN     RM   SIZE  RO  TYPE MOUNTPOINTS
sda            8:0        0    20G   0  disk
├─sda1         8:1        0     1G   0  part /boot
├─sda2         8:2        0    19G   0  part 
   └─cs-root 253:0        0    17G   0  lvm  /
   └─cs-swap 253:1        0     2G   0  lvm
sdb            8:16       0    20G   0  disk
└─sdb1         8:17       0     5G   0  part
sdc            8:32       0    20G   0  disk
└─sdc1         8:33       0    20G   0  part
sr0           11:0        1  1024M   0  rom  /run/media/USER/cenots-8.1.1911-x86_64-dvd
```
### Making mounts permanent
- to make the mounts permanent, we need to add the mount points to the **``/etc/fstab``** file.

#### Mounting ``/dev/sdb1`` to ``/home/data/sdb1`` permanently -ext4
- create a directory **``data/sdb1``** in the **``/home``** directory. 
```bash
sudo mkdir -p /home/data/sdb1
```
- after making the mount point, we need to edit the **``/etc/fstab``** file. 
```bash
sudo vim /etc/fstab
```
- add the following lines to the file. 
```
/dev/sdb1 /home/data/sdb1 ext4 defaults 0 0
```
- save and exit the file.
- do a **``mount -a``** to mount all the file systems in the **``/etc/fstab``** file. 
```bash
sudo mount -a
```
- list the block devices and their partitions and file systems. 
```bash
lsblk
```
```
NAME         MAJ:MIN     RM   SIZE  RO  TYPE MOUNTPOINTS
sda            8:0        0    20G   0  disk
├─sda1         8:1        0     1G   0  part /boot
├─sda2         8:2        0    19G   0  part 
   └─cs-root 253:0        0    17G   0  lvm  /
   └─cs-swap 253:1        0     2G   0  lvm
sdb            8:16       0    20G   0  disk
└─sdb1         8:17       0     5G   0  part /home/data/sdb1
sdc            8:32       0    20G   0  disk
└─sdc1         8:33       0    20G   0  part
sr0           11:0        1  1024M   0  rom  /run/media/USER/cenots-8.1.1911-x86_64-dvd
```
#### Mounting ``/dev/sdc1`` to ``/home/data/sdc1`` permanently -xfs
- create a directory **``data/sdc1``** in the **``/home``** directory. 
```bash
sudo mkdir -p /home/data/sdc1
```
- after making the mount point, we need to edit the **``/etc/fstab``** file. 
```bash
sudo vim /etc/fstab
```
- add the following lines to the file. 
```
/dev/sdc1 /home/data/sdc1 xfs defaults 0 0
```
- save and exit the file.
- do a **``mount -a``** to mount all the file systems in the **``/etc/fstab``** file. 
```bash
sudo mount -a
```
- list the block devices and their partitions and file systems. 
```bash
lsblk
```
```
NAME         MAJ:MIN     RM   SIZE  RO  TYPE MOUNTPOINTS
sda            8:0        0    20G   0  disk
├─sda1         8:1        0     1G   0  part /boot
├─sda2         8:2        0    19G   0  part 
   └─cs-root 253:0        0    17G   0  lvm  /
   └─cs-swap 253:1        0     2G   0  lvm
sdb            8:16       0    20G   0  disk
└─sdb1         8:17       0     5G   0  part /home/data/sdb1
sdc            8:32       0    20G   0  disk
└─sdc1         8:33       0    20G   0  part /home/data/sdc1
sr0           11:0        1  1024M   0  rom  /run/media/USER/cenots-8.1.1911-x86_64-dvd
```
### ``findmnt`` Utility
- ``findmnt`` is a command-line utility that is used to list all the mounted file systems.
- ``findmnt`` is used without any arguments. 
```bash
findmnt
```

