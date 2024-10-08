### Connecting to a Server
This section contains notes on connecting to a server ssh, working with linux from windows, sudo configuration, etc.
#### Detailed Notes
- [Root User](/ssh/11-root.md)
- [``ssh``](/ssh/12-ssh.md)
#### TL;DR
##### Root User
- **Description**: Superuser with highest privileges; can perform any task.
- **Caution**: Use only when necessary to avoid system damage.

##### `sudo`
- **Description**: Run commands with root privileges.
- **Best Practice**: Preferred over using root directly.
- **Admin Users**: Members of `wheel` (Red Hat) or `sudo` (Debian) groups don't need `sudo`.

###### Examples
| Command | Description |
|---------|-------------|
| `sudo passwd` | Change root password. |
| `sudo -i` | Open a root shell (not recommended). |

##### `su`
- **Description**: Switch to another user account, including root.
- **Usage**:
  - Open subshell or login shell.
  - Switch to another user without password if already root.

###### Examples
| Command | Description |
|---------|-------------|
| `su` | Switch to another user account. |
| `sudo passwd` | Change root password. |
| `su - ` | Open root shell |
| `sudo -i` | Open a root shell | 


##### `sudo` Configuration
- **`visudo`**: Safely edit `/etc/sudoers` file.
  ```bash
  sudo visudo
  ```
Some Example Configurations:
| Distribution | Configuration | Description |
|--------------|---------------|-------------|
| RHEL | `%wheel ALL=(ALL) ALL` | Enable sudo access for `wheel` group. |
| Debian | `%sudo ALL=(ALL:ALL) ALL` | Enable sudo access for `sudo` group. |
| RHEL | `%wheel ALL=(ALL) NOPASSWD: ALL` | Enable sudo access without password. |
| Debian | `%sudo ALL=(ALL:ALL) NOPASSWD: ALL` | Enable sudo access without password. |
| RHEL/Debian | `Defaults timestamp_type=global,timestamp_timeout=300` | Cache sudo credentials for 5 hours. |
| RHEL/Debian | `exampleuser ALL=/usr/bin/passwd, /usr/sbin/useradd, /usr/sbin/userdel, /usr/sbin/usermod` | Allow `exampleuser` to run user management commands. |	
| RHEL/Debian | `sudo useradd someuser` | Add `someuser` as a new user. |
| RHEL/Debian | `sudo userdel someuser` | Delete `someuser`. |
| RHEL | `sudo usermod -aG wheel someuser` | Add `someuser` to `wheel` group. |
| Debian | `sudo usermod -aG sudo someuser` | Add `someuser` to `sudo` group. |
| RHEL/Debian | `sudo passwd someuser` | Change password for `someuser`. |

##### SSH
- use ``ssh`` to connect to a remote server.
```bash	
ssh user@hostname
```
or 
```bash
ssh user@ip_address
```
###### Installation
- Red Hat/CentOS
  ```bash
  sudo dnf update && sudo dnf  install openssh-server; 
  ```
  or 
  ```bash
  sudo yum install openssh-server;
  ```
- Ubuntu/Debian
  ```bash
  sudo apt update && sudo apt install openssh-server
  ```
  ###### Enable and Start SSH Service
  - Red Hat/CentOS
    ```bash
    sudo systemctl start sshd
    sudo systemctl enable --now sshd
    ```
  - Ubuntu/Debian
    ```bash
    sudo systemctl start ssh
    sudo systemctl enable --now ssh
    ```
###### Firewall Configuration
- Red Hat/CentOS
  ```bash
  sudo firewall-cmd --permanent --add-service=ssh
  sudo firewall-cmd --reload
  ```
- Ubuntu/Debian
  ```bash
  sudo ufw allow ssh
  sudo ufw enable
  ```
###### Find Server IP Address
```bash	
ip addr show
```
###### Copy Files (Secure Copy)
- Copy from server to client
  ```bash
  scp user@hostname:/path/to/source /path/to/destination
  ```
- Copy from client to server
  ```bash
  scp /path/to/destination user@ip_address:/path/to/source 
  ```