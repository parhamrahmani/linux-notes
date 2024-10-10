# Systemd
Systemd is a init system and system manager for Linux operating systems. It is a replacement for the traditional SysV init system. Systemd is the first process that starts right after the kernel. It is responsible for starting services, processes, mounts, timers, paths, etc. 
  
  - [Examples](/systemd/README.md/#examples)
  - [Command Summary](/systemd/README.md/#commands-review)
- [Systemd](#systemd)
  - [Units](#units)
  - [Managing Services](#managing-services)
    - [Common Commands](#common-commands)
    - [Service Configuration Files](#service-configuration-files)
  - [Managing Targets](#managing-targets)
    - [Common Commands](#common-commands-1)
  - [Managing Services in WSL](#managing-services-in-wsl)
  - [Advanced Systemd](#advanced-systemd)
    - [Modifying Systemd Units](#modifying-systemd-units)
    - [Managing Systemd Sockts](#managing-systemd-sockts)
      - [``ListenStream`` and ``ListenDatagram``](#listenstream-and-listendatagram)
    - [Managing Systemd Timers](#managing-systemd-timers)
      - [``OnCalendar`` , ``OnBootSec`` and ``OnUnitActiveSec``](#oncalendar--onbootsec-and-onunitactivesec)
      - [``systemd.time`` and ``systemd.timer``](#systemdtime-and-systemdtimer)
    - [Systemd Cgroups](#systemd-cgroups)
      - [Managing Cgroups](#managing-cgroups)
        - [Slices](#slices)
    - [Managing Dependencies](#managing-dependencies) 
    - [Systemd Self-Healing](#systemd-self-healing)

## Units
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
| ``systemctl list-unit-files -t socket`` | List all socket units |
| ``systemctl list-unit-files -t service`` | List all service units |
| ``systemctl list-unit-files -t timer`` | List all timer units |	
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
---
***See this example with ``nginx`` for a practical example:***
  - ***[Installing a Service and Enabling it - ``Nginx``](/systemd/README.md/#installing-a-service-and-enabling-it)***

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

***See these examples below for a practical example:***
  - ***[Service Configuration Files](/systemd/README.md/#service-configuration-files)***
  - ***[Showing a Service Configuration File and Editing it](/systemd/README.md/#showing-a-service-configuration-file-and-editing-it)***


## Managing Targets

- A target is a group of services that should be started or stopped together. 
- Isolatble targets are used to boot the system into a specific state. 
  - emergency.target: Boots the system into an emergency shell.
  - rescue.target: Boots the system into a rescue shell.
  - multi-user.target: Boots the system into a multi-user shell.
  - graphical.target: Boots the system into a graphical shell (GUI).
There are the targets that you can boot the system into.
- other targets are called groups and they are used to group services together.

### Common Commands

| Command | Description |
|---------|-------------|
| ``systemctl get-default`` | Show the default target |
| ``systemctl list-dependencies target`` | List the dependencies of a target |
| ``systemctl list-units --type=target`` | List all available targets |
| ``systemctl start target`` | Start a target |
| ``systemctl isolate target`` | Boot the system into a specific target |
| ``systemctl set-default target`` | Set the default target |

***See these examples for a practical example:***
  - ***[Listing all Available Targets and its Dependencies](/systemd/README.md/#listing-all-available-targets-and-its-dependencies)***
  - ***[Changing the Default Target and Booting into a Specific Target](/systemd/README.md/#changing-the-default-target-from-graphical-to-multi-user)***

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

### Modifying Systemd Units
- showing possible unit parameters
```bash
systemctl show unit.type
```
- modifying a unit
```bash
sudo systemctl edit unit.type
```
- reloading the configuration
```bash
sudo systemctl daemon-reload
```
- restarting the service
```bash
sudo systemctl restart unit.type
sudo systemctl status unit.type
```
- setting the default editor for systemctl
```bash
# using nano
export SYSTEMD_EDITOR=/usr/bin/nano
# using vim
export SYSTEMD_EDITOR=/usr/bin/vim
```
***See the examples below for a practical example:***
  - ***[changing the Memnory Max Usage of a ``sshd`` service](/systemd//README.md/#changing-the-memnory-max-usage-of-a-sshd-service)***

### Managing Systemd Sockts
- A systemd socket is used with a service to start the service when the traffic comes in on a specific socket.
     - have the same name as the service but with a ``.socket`` extension.
     - while using sockets, the socket is starts/enables and not the service.
#### ``ListenStream`` and ``ListenDatagram``
- ``ListenStream``: Specifies the IP address and port number on which the socket should listen for TCP traffic.
- ``ListenDatagram``: Specifies the IP address and port number on which the socket should listen for UDP traffic.

***Note***: Some sockets come pre-configured with the service and are maybe enabled by default. By running ``sudo systemctl list-units --type=socket`` you can see the status of the sockets and the services they are associated with. If there is no socket associated with a service, you can create a socket file for the service and enable the socket to start the service when the traffic comes in on the specified port. The socket's name has to be same with the service's name but with a ``.socket`` extension. 

***See the examples below for a practical example:***
  - ***[Managing Sockets in Systemd - Activating Cockpit Socket](/systemd/README.md/#managing-sockets-in-systemd---activating-cockpit-socket)***

### Managing Systemd Timers
Just like sockets, timers are associated with services with the same names as them with an ``.timer`` extension and timers being started or enabled doesn't start or enable the service. It is used to start the service at a specific time or interval. 
#### ``OnCalendar`` , ``OnBootSec`` and ``OnUnitActiveSec``
- ``OnCalendar``: Specifies the calendar time when the timer should be started in cron-like format.
- ``OnBootSec``, ``OnUnitActiveSec``: Specifies the time after boot when the timer should be started based on other events. 
#### ``systemd.time`` and ``systemd.timer``
The documentation for the systemd time formats and others can be found in ``man 7 systemd.time`` or ``man systemd.timer``.

- It can be a good alternative to cron jobs in modern linux systems.

***See the examples below for a practical example:***
  - ***[Timers in Systemd](/systemd/README.md/#timers-in-systemd)***

### Systemd Cgroups
Systemd organizes processes with cgroups, this is a Linux kernel feature to limit, police and account the resource usage of certain processes (actually process groups). Control groups place resources in controllers that represent the resource type. Some of the controllers are:
 - cpu 
 - memory 
 - devices 
 - blkio 

and many more.
These controllers are used to limit the resources that a process can use and are subdivided into hierarchies or a tree structure where different weights and limits can be set to the branches of the tree.

#### Managing Cgroups
- ``cgconfig`` and ``cgred`` are the tools used to manage cgroups manually. Not very common, since it was used before systemd was introduced.
- ``/sys/fs/cgroup`` is the directory where the cgroups settings are stored.
##### Slices
Systemd uses slices to group units together. Systemd divides ``cpu``, ``cpuacct``, ``memory`` and ``blkio`` controllers into slices:
- ``system.slice``: Contains system services, processes and daemons.
- ``machine.slice``: Contains virtual machines.
- ``user.slice``: Contains user services and processes. 

***These are default slices and you can create your own slices too.***

In the diagram below, you can see the hierarchy of the slices.

![slices](/systemd/slices.drawio.png)

So for example, if on the user slice there is only one user logged in, the user slice will get all the cpu share designated to it. If there are two users logged in, the cpu share will be divided equally between the two users and so on. If only a user is existent and gets all the cpu share, it is somewhat equal to all cpu shares that the system slice and its scopes and unites get. 

***See the examples below for a practical example:***
  - ***[CPU Shares ans Weights in Systemd](/systemd/README.md/#cpu-shares-and-weights-in-systemd)***

To see the cgroups, scopes and slices, you can use:
```bash
systemd-cgls
```
and to see the current cpu share and usage of slices, its processes and units, you can use:
```bash
systemd-cgtop
```

These normally wouldn't be used for monitoring, but it is useful to have a look at slices, scopes and units and their activity. 

### Managing Dependencies
In the ``[Unit]`` section of a unit file, you can specify dependencies for the unit. This is done with the ``Requires`` and ``After`` directives, or with the ``Wants`` and ``Before`` directives.

- ``before``: Specifies that the unit should start before the listed units.
- ``after``: Specifies that the unit should start after the listed units.
- ``requires``: Specifies that the listed units are required for the unit to start. This alos means that if the listed units fail, the unit will fail too.
- ``wants``: Specifies that the listed units are wanted by the unit but are not required for the unit to start. This means that if the listed units fail, the unit will still start.

**Note: Using targets is a better way to manage dependencies.**

***See the examples below for a practical example:***
  - ***[Managing Dependencies in systemd - ``requires``](/systemd/README.md/#managing-dependencies-in-systemd)***

### Systemd Self-Healing
Systemd has a self-healing mechanism that can be used to restart a service if it fails. This is done with the ``Restart`` directive in the ``[Service]`` section of the unit file. This contributes to the high availability of the service.

- ``Restart=always``: Restarts the service if it fails. Other options are ``on-failure``, ``on-abnormal``, ``on-success`` and ``on-abort``.
- ``RestartSec=5``: Specifies the time to wait before restarting the service.

***See the examples below for a practical example:***
  - ***[Self-Healing in Systemd](/systemd/README.md/#self-healing-in-systemd)***

