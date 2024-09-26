# SSH

### Using `ssh` to connect to a remote server
#### Definition
- `ssh` stands for *Secure Shell*. It is a network protocol that allows secure communication between two systems.
### Installation and Usage
#### Installation
###### RHEL/CentOS
- `ssh` is installed by default in RHEL/CentOS. If it is not installed, you can install it using the following command:
```bash
sudo dnf install openssh-server; 
sudo systemctl enable --now sshd
```
###### Ubuntu/Debian
- `ssh` is installed by default in Ubuntu/Debian. If it is not installed, you can install it using the following command:
```bash
sudo apt install openssh-server
```
#### Usage
##### `ssh`
An `ssh` client is used to connect to a remote server. 
###### Linux/MacOS
a native `ssh` client is available in Linux and MacOS. 
###### Windows
- You can use `PuTTY` as an `ssh` client in Windows. You can download it from [here](https://www.putty.org/).
- MobaXterm is another popular `ssh` client for Windows. You can download it from [here](https://mobaxterm.mobatek.net/). 
##### `scp` 
- `scp` stands for *Secure Copy*. It is used to securely copy files between two systems.
###### Linux/MacOS
Example:
```bash
scp /etc/hosts 192.168.29.111:/tmp/
```
###### Windows
- You can use `WinSCP` to copy files between two systems. You can download it from [here](https://winscp.net/eng/download.php).

#### Demo Scenario
##### Description
- First set up two VMs, one acting as the client and the other as the server. In Oracle VirtualBox, you can set up a host-only network to connect the two VMs.
- Make one VM as the server (CentOS) and the other as the client (Ubuntu).
- Now we need to install necessary packages on both VMs.
    - CentOS (Server)
    ```bash
    sudo yum update
    sudo yum install openssh-server
    ``` 
    - Ubuntu (Client)
    ```bash
    sudo apt update
    sudo apt install openssh-server
    ```
- Now we need to start the `sshd` service on the server and `ssh` service on the client.
    - CentOS (Server)
    ```bash
    sudo systemctl start sshd
    sudo systemctl enable sshd
    ```
    - Ubuntu (Client)
    ```bash
    sudo systemctl start ssh
    sudo systemctl enable ssh
    ```
- Now we should configure the firewall on the server to allow `ssh` traffic.
    - CentOS (Server)
    ```bash
    sudo firewall-cmd --permanent --add-service=ssh
    sudo firewall-cmd --reload
    ```
    - Ubuntu (Client)
    ```bash
    sudo ufw allow ssh
    sudo ufw enable
    ```
- Now we need to find the IP address of the server.
    - CentOS (Server)
    ```bash
    ip addr show
    ```
    - Ubuntu (Client)
    ```bash
    ip addr show
    ```
- Now we can connect to the server from the client using `ssh`.
    - Ubuntu (Client)
    ```bash
    ssh <username>@<server-ip>
    ```
    ```
    ssh server@192.168.56.101
    ```	
- After connecting to the server, you can copy files from the server to the client using `scp`.
    - Ubuntu (Client)
    ```bash
    scp <username>@<server-ip>:<source-file> <destination-file>
    ```
    ```
    scp server@192.168.56.101:/etc/hosts /tmp/
    ``` 
- You can also copy files from the client to the server using `scp`.
    - Ubuntu (Client)
    ```bash
    scp <source-file> <username>@<server-ip>:<destination-file>
    ```
    ```
    scp /etc/hosts server@192.168.56.101:/tmp/
    ```

### Working with Linux from Windows
#### ``MobaXterm``
- `MobaXterm` is a popular `ssh` client for Windows. You can download it from [here](https://mobaxterm.mobatek.net/download.html)
#### ``PuTTY``
- `PuTTY` is another popular `ssh` client for Windows. You can download it from [here](https://www.putty.org/).
#### ``WinSCP``
- `WinSCP` is used to copy files between two systems. You can download it from [here](https://winscp.net/eng/download.php).

### Managing ``SSH``