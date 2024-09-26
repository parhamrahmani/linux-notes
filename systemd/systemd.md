# Systemd
Systemd is a init system and system manager for Linux operating systems. It is a replacement for the traditional SysV init system. Systemd is the first process that starts right after the kernel. It is responsible for starting services, processes, mounts, timers, paths, etc. 

- [Systemd](#systemd)
    - [Units](#units)
  - [Managing Services](#managing-services)
    - [Common Commands](#common-commands)
      - [Example](#example)
    - [Service Configuration Files](#service-configuration-files)
      - [Examples](#examples)
  - [Managing Targets](#managing-targets)
    - [Example](#example-1)
    - [Common Commands](#common-commands-1)
      - [Examples](#examples-1)
  - [Managing Services in WSL](#managing-services-in-wsl)
  - [Advanced Systemd](#advanced-systemd)

  

### Units
- A unit is a configuration file that describes how a service, socket, device, mount point, or other resource should be managed by systemd.
- Units are stored in `/etc/systemd/system/` and `/usr/lib/systemd/system/`
  
## Managing Services
``systemctl`` is the main command to manage services in systemd.
### Common Commands
| Command | Description |
|---------|-------------|
| ``systemctl -t help`` | List all unit types |
| ``systemctl list-unit-files`` | List all unit files |
| ``systemctl list-units`` | List all active units |
| ``systemctl enable name.service`` | Enable a service to start at boot |
| ``systemctl disable name.service`` | Disable a service to start at boot |
| ``systemctl start name.service`` | Start a service |
| ``systemctl stop name.service`` | Stop a service |
| ``systemctl restart name.service`` | Restart a service |
| ``systemctl reload name.service`` | Reload a service |
| ``systemctl status name.service`` | Show status of a service |
| ``systemctl show name.service`` | Show all properties of a service |
| ``systemctl cat name.service`` | Show the configuration file of a service |
| ``systemctl edit name.service`` | Edit the configuration file of a service |
| ``systemctl daemon-reload`` | Reload the configuration files of systemd |

- ***enable vs start***:
  - enable: Sets up a unit (service) to start automatically at boot time.
  - start: Immediately starts a unit.

- ***disable vs stop vs kill***:
    - disable: Removes the unit from starting automatically at boot.
    - stop: Gracefully stops a running unit.
    - kill: Forcefully terminates a unit without giving it time to clean up.

- ***restart vs reload***:
    - restart: Stops and then starts a unit. This is a full reinitialization.   
    - reload: Reloads the configuration of a unit without stopping it. This is less disruptive but not all services support it.

```bash
# a service starts automatically at boot and don't affect the current running state of the service.
sudo systemctl enable servicename
sudo systemctl disable servicename

# immediately change the running state of a service and don't affect whether the service starts at boot.
sudo systemctl start servicename
sudo systemctl stop servicename

#  more aggressive way to stop a service only when 'stop' doesn't work or you need to terminate immediately.
sudo systemctl kill servicename

# a stop followed by a start and useful for applying major changes that require a full service restart.
sudo systemctl restart servicename

# this tells the service to reload its configuration files. less disruptive than restart
sudo systemctl reload servicename
```

#### Example
- let's install and enable nginx
```bash	
# install nginx
sudo dnf install nginx
# enable nginx
sudo systemctl enable nginx.service
```
```
Created symlink /etc/systemd/system/multi-user.target.wants/nginx.service → /usr/lib/systemd/system/nginx.service.
```
this will enable nginx to start at boot by creating a symlink to the service file in the multi-user target directory.
when we check the status of the service, we can see that the service is disabled.

if you want to start nginx right away, you can use:
```bash
sudo systemctl start nginx
```
after starting nginx, you can check the status of the service using
```bash
sudo systemctl status nginx
```
### Service Configuration Files
- to show the configuration file of a service, you can use:
```bash
systemctl cat servicename
```
- to show all available configuration files
```bash	
systemctl show 
# for a specific service
systemctl show servicename
```
- to edit a service configuration file
```bash
sudo systemctl edit servicename
```
this will open a new file in the editor where you can override the default configuration of the service.
After making changes, you can reload the service to apply the changes.
```bash
sudo systemctl daemon-reload
```
#### Examples
- let's see the configuration file of sshd service
```bash
sudo systemctl cat sshd
```
it leads you to ``/usr/lib/systemd/system/sshd.service`` file.
In the file we have the following content:
```
[Unit]
Description=OpenSSH server daemon 
Documentation=man:sshd(8) man:sshd_config(5)
After=network.target sshd-keygen.service 
Wants=sshd-keygen.service
```
This is the unit configuration file for the sshd service. It contains the description of the service, documentation, and dependencies.
Then we have
```
[Service]
Type=notify 
EnvironmentFile=-/etc/sysconfig/sshd
ExecStart=/usr/sbin/sshd -D $OPTIONS
ExecReload=/bin/kill -HUP $MAINPID
KillMode=process
Restart=on-failure
```
This is the service configuration file for the sshd service. It contains the type of the service, environment variables, the command to start the service, the command to reload the service, the kill mode, and the restart policy.
Then we have
```
[Install]
WantedBy=multi-user.target
```
This is the install configuration file for the sshd service. It contains the target where the service should be enabled.

- let's edit the configuration file of httpd service
```bash
sudo systemctl edit httpd
```
```
### Edititng /etc/systemd/system/httpd.service.d/.#override.conf9ab1033efb7e4e7b
### Anything between here and the comment below will become the new contents of the file

### Lines below this comment will be discarded

```
So the response shown at the start of the file is a comment that tells you that anything between the two comments will be the new content of the file. You can add your custom configuration here. After saving the file, you can reload the service to apply the changes.

let's add ``Restart=on-failure`` and ``RestartSec=42s`` to the configuration file.
```
### Edititng /etc/systemd/system/httpd.service.d/.#override.conf9ab1033efb7e4e7b
### Anything between here and the comment below will become the new contents of the file
Restart=on-failure
RestartSec=5s
### Lines below this comment will be discarded

```
let's see the changes
```bash
sudo systemctl cat httpd
```
```
# /usr/lib/systemd/system/httpd.service.d/override.conf
Restart=on-failure
RestartSec=5s
```
At the end of the file, you can see the changes you made to the service configuration file.

let's reload the service to apply the changes and start the service
```bash
sudo systemctl daemon-reload # reload the configuration files
sudo systemctl start httpd
sudo systemctl status httpd
```
The added configuration will make the service restart after a failure and wait for 5 seconds before restarting.

## Managing Targets

- A target is a group of services that should be started or stopped together. 
- Isolatble targets are used to boot the system into a specific state. 
  - emergency.target: Boots the system into an emergency shell.
  - rescue.target: Boots the system into a rescue shell.
  - multi-user.target: Boots the system into a multi-user shell.
  - graphical.target: Boots the system into a graphical shell (GUI).
There are the targets that you can boot the system into.
- other targets are called groups and they are used to group services together.

### Example
- to list the dependencies of a target
```bash
systemctl list-dependencies <target>
```
- let's see the default target
```bash
systemctl get-default
```
```
graphical.target
```
This means that the system boots into the graphical target by default. Which is the desktop environment. 
- let's see the dependencies of the graphical target
```bash
systemctl list-dependencies graphical.target
```
The results shows the dependencies of the graphical target. It shows the services that are required to start the graphical target, etc. 

- Let's list all available targets
```bash
systemctl list-units --type=target
# or
systemctl list-units -t target
```
This will list all available targets on the system. 

### Common Commands

| Command | Description |
|---------|-------------|
| ``systemctl get-default`` | Show the default target |
| ``systemctl list-dependencies target`` | List the dependencies of a target |
| ``systemctl list-units --type=target`` | List all available targets |
| ``systemctl start target`` | Start a target |
| ``systemctl isolate target`` | Boot the system into a specific target |
| ``systemctl set-default target`` | Set the default target |

#### Examples
- let's change the default target to multi-user target
```bash
sudo systemctl set-default multi-user.target
```
```
Removed /etc/systemd/system/default.target.
Created symlink /etc/systemd/system/default.target → /usr/lib/systemd/system/multi-user.target.
```
This will change the default target to the multi-user target. This means that the system will boot into the multi-user target by default.

- let's boot the system into the emergency target
```bash
sudo systemctl isolate emergency.target
```
This will boot the system into the emergency target. This is useful when you need to troubleshoot the system.
**Note**: In the VM that I am using, this didn't work properly and the VM went into a black screen without being able to do anything. How to fix this?
- Reboot the VM
- When the GRUB menu appears, press 'e' to edit the boot options
- Find the line that starts with 'linux' and add 'systemd.unit=emergency.target' at the end of the line and press 'Ctrl+x' to boot into the emergency target.
- now let's start the default target back to graphical target
```bash
sudo systemctl start default.target
```
This will start a console-like interface. after giving the credentials, you can start the graphical target using
```bash
systemctl set-default graphical.target
```
This will set the default target to the graphical target. This means that the system will boot into the graphical target by default.
- let's start the default target again
```bash
sudo systemctl start default.target
```
This will start the graphical target.

## Managing Services in WSL
In WSL the boot procedure is not done with systemd. This means that you can't use systemctl to manage services in WSL. The processes in WSL are less than a linux on a physical machine or in a VM, since most background services are running in the Windows host. However there is a way to manage services in WSL.

- We are in an Ubuntu WSL
- let's install nginx
```bash
sudo apt update && sudo apt install nginx
```
- let's start nginx
the system has not been booted with systemd as the init system. This means that you can't use systemctl to manage services in WSL. However, you can still manage services in WSL using the ``service`` command.
```bash	
sudo service nginx start
```
- let's check the status of nginx
```bash
sudo service nginx status
```
- let's stop nginx
```bash
sudo service nginx stop
```
- let's restart nginx
```bash
sudo service nginx restart
```

## Advanced Systemd