# Systemd
## Contents
- ### [Introduction to Systemd](/systemd/systemd.md/#systemd)
  - [What is Systemd](/systemd/systemd.md/#systemd)
  - [Systemd Services](/systemd/#managing-services)
  - [Systemd Targets](/systemd/#managing-targets)
  - [Managing Services in WSL](/systemd/systemd.md/#managing-services-in-wsl)
- ### [Advanced Systemd](/systemd/systemd.md/#advanced-systemd)
   - [Modifying Systemd Units](/systemd/systemd.md/#modifying-systemd-units)
   - [Managing Systemd Sockets](/systemd/systemd.md/#managing-systemd-sockts)
   - [``systemd.time`` and ``systemd.timer``](/systemd/systemd.md/#systemdtime-and-systemdtimer)
   - [Systemd Cgroups](/systemd/systemd.md/#systemd-cgroups)

  
- ### [Quick Summary](/systemd/README.md/#summary)
    - #### [Commands Review](#commands-review)
    - #### [Examples](#examples)
        - [Installing a Service and Enabling it](#installing-a-service-and-enabling-it) 
        - [Service Configuration Files](#service-configuration-files) 
        - [Showing a Service Configuration File and Editing it](#showing-a-service-configuration-file-and-editing-it)
        - [Listing all Available Targets and its Dependencies](#listing-all-available-targets-and-its-dependencies)
        - [Changing the Default Target from Graphical to Multi-User](#changing-the-default-target-from-graphical-to-multi-user)
        - [Managing Services in WSL](#managing-services-in-wsl)
        - [changing the Memnory Max Usage of a ``sshd`` service](#changing-the-memnory-max-usage-of-a-sshd-service)
        - [Managing Sockets in Systemd - Activating Cockpit Socket](#managing-sockets-in-systemd---activating-cockpit-socket)
        - [Timers in Systemd](#timers-in-systemd)
        - [CPU Shares and Weights in Systemd](#cpu-shares-and-weights-in-systemd)
        - [Managing Dependencies in Systemd](#managing-dependencies-in-systemd)
        - [Self-Healing in Systemd](#self-healing-in-systemd)
        - [Summary Example](#summary-example)

## Summary
### Commands Review
#### Systemd Commands
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
| ``systemctl get-default`` | Show the default target |
| ``systemctl list-dependencies target`` | List the dependencies of a target |
| ``systemctl list-units --type=target`` | List all available targets |
| ``systemctl start target`` | Start a target |
| ``systemctl isolate target`` | Boot the system into a specific target |
| ``systemctl set-default target`` | Set the default target |

#### Managing Services in WSL

| Command | Description |
|---------|-------------|
| ``sudo service name start`` | Start a service |
| ``sudo service name stop`` | Stop a service |
| ``sudo service name restart`` | Restart a service |
| ``sudo service name status`` | Show the status of a service |
| ``sudo service name reload`` | Reload a service |
| ``sudo service name force-reload`` | Force reload a service |
| ``sudo service name enable`` | Enable a service to start at boot |
| ``sudo service name disable`` | Disable a service to start at boot |
| ``sudo service --status-all`` | Show the status of all services |
| ``sudo service --full-restart`` | Restart all services |
| ``sudo service --full-status`` | Show the status of all services |

#### Managing Systemd Cgroups
| Command | Description |
|---------|-------------|
| ``systemd-cgls`` | List all control groups |
| ``systemd-cgtop`` | Show the top control groups |

### Examples
#### Installing a Service and Enabling it
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
---
#### Showing a Service Configuration File and Editing it
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

---
#### Listing all Available Targets and its Dependencies
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

---
#### Changing the Default Target from Graphical to Multi-User
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

---
#### Managing Services in WSL
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
##### changing the Memnory Max Usage of a ``sshd`` service
- let's see the properties of the sshd service
```bash
sudo systemctl show sshd
```
press ``/`` and search for ``MemoryMax``. This will show you the value of the ``MemoryMax`` property.
```
MemoryMax=infinity
```
- what does ``MemoryMax`` mean?
```bash
sudo man systemd.directives
```
press ``/`` and search for ``MemoryMax``. This will show you the description of the ``MemoryMax`` property.
```
MemoryMax=
  systemd.resource-control(5)
```
This means that the property is described in the systemd.resource-control(5) manual. You can press ``q`` to exit the manual.
```bash	
sudo man systemd.resource-control
```
press ``/`` and search for ``MemoryMax``. This will show you the description of the ``MemoryMax`` property.
```
       MemoryMax=bytes

           Specify the absolute limit on memory usage of the executed processes
           in this unit. If memory usage cannot be contained under the limit, 
           out-of-memory killer is invoked inside the unit. 
           It is recommended to use MemoryHigh= as the main control mechanism
           and use MemoryMax= as the last line of defense.

           Takes a memory size in bytes. If the value is suffixed with K, M, G
           or T, the specified memory size is parsed as Kilobytes, Megabytes, 
           Gigabytes, or Terabytes (with the base 1024), respectively. Alternatively,
           a percentage value may be specified, which is taken relative to the installed
           physical memory on the system. If assigned the special value "infinity", 
           no memory limit is applied. This controls the "memory.max" control group attribute. 
           For details about this control group attribute, see Memory Interface Files[5].
  ```
This manual shows the **Resource Control**. The ``MemoryMax`` property specifies the absolute limit on memory usage of the executed processes in the unit. If memory usage cannot be contained under the limit, the out-of-memory killer is invoked inside the unit. It is recommended to use ``MemoryHigh`` as the main control mechanism and use ``MemoryMax`` as the last line of defense.

- Now that we know what the ``MemoryMax`` property means, let's modify the sshd service to set the maximum memory usage of the executed processes.
```bash
# see the already existing configuration
sudo systemctl cat sshd
# edit the configuration
sudo systemctl edit sshd
```
```
### Edititng /etc/systemd/system/httpd.service.d/.#override.conf9ab1033efb7e4e7b
### Anything between here and the comment below will become the new contents of the file
[Service]
MemoryMax=10M
### Lines below this comment will be discarded
```
This will set the ``MemoryMax`` property to ``10M``. Save the file and exit the editor.
Now let's reload the configuration of the sshd service to apply the changes.
```bash
sudo systemctl daemon-reload
```
This will reload the configuration of the sshd service. Now let's restart the sshd service to apply the changes.
```bash
sudo systemctl restart sshd
```
This will restart the sshd service. You can check the status of the service to see if the changes have been applied.
```bash
sudo systemctl status sshd
```
This will show the status of the sshd service. You can see the properties of the service and check if the ``MemoryMax`` property has been set to ``10M``.
```bash
sudo systemctl show sshd
```
This will show the properties of the sshd service. You can press ``/`` and search for ``MemoryMax`` to see the value of the ``MemoryMax`` property.
```
MemoryMax=10485760
```
This means that the ``MemoryMax`` property has been set to ``10M``. The changes have been applied successfully.

---
#### Managing Sockets in Systemd - Activating Cockpit Socket
let's list all available sockets
```bash
systemctl list-units --type=socket
```
This will list all available sockets on the system. You can see the status of the sockets and the services they are associated with.
for example, the sshd service has a socket associated with it. You can see the status of the socket and the service it is associated with.
```bash
systemctl status sshd.socket
```
or ``cockpit.socket`` which is associated with the cockpit service and is very common in redhat based systems.
```bash
systemctl status cockpit.socket
```
let's deep diver into the ``cockpit.socket`` 
```bash
sudo systemctl cat cockpit.socket
```
```
# /usr/lib/systemd/system/cockpit.socket
[Unit]
Description=Cockpit Web Service Socket
Documentation=man:cockpit-ws(8)
Wants=cockpit-motd.service

[Socket]
ListenStream=9090
ExecStart=-/usr/share/cockpit/motd/update-motd '' localhost
ExecStartPost=-/bin/ln -snf active.motd /run/cocpit/motd
ExecStopPost=-/bin/ln -snf inactive.motd /run/cockpit/motd

[Install]
WantedBy=sockets.target
```
The default port for the cockpit service is ``9090``. The ``ListenStream`` property specifies the IP address and port number on which the socket should listen for TCP traffic. The ``ExecStart`` property specifies the command to run when the socket is started. The ``ExecStartPost`` property specifies the command to run after the socket is started. The ``ExecStopPost`` property specifies the command to run after the socket is stopped. The ``WantedBy`` property specifies the target where the socket should be enabled.

- let's see the status of the cockpit service
```bash
systemctl status cockpit
```
```
o cockpit.service - Cockpit Web Service
     Loaded: loaded (/usr/lib/systemd/system/cockpit.service; static)
     Active: inactive (dead)
  TriggeredBy: o cockpit.socket
       Docs: man:cockpit-ws(8)
```
the circle in the ``TriggeredBy`` column shows that the socket is disabled. 

- let's enable the cockpit socket
```bash
sudo systemctl enable cockpit.socket
```
```
Created symlink /etc/systemd/system/sockets.target.wants/cockpit.socket → /usr/lib/systemd/system/cockpit.socket.
```
to make the changes take effect, you need to reload the systemd configuration
```bash
sudo systemctl daemon-reload
sudo systemctl restart cockpit.socket
```
now let's check the status of the cockpit service
```bash
systemctl status cockpit
```
the circle in the ``TriggeredBy`` column shows that the socket is enabled because it's full and green.
```
o cockpit.service - Cockpit Web Service
     Loaded: loaded (/usr/lib/systemd/system/cockpit.service; static)
     Active: inactive (dead)
  TriggeredBy: ● cockpit.socket
      Docs: man:cockpit-ws(8)
```
this means still the cokcpit service is inactive, but the socket is enabled and the service will start when the traffic comes in on the specified port. 

let's go to ``localhost:9090`` in the browser to see the cockpit service.

![Screenshot](/systemd/Screenshot%202024-10-01%20163051.png)

let's check the status of the cockpit service again
```bash
systemctl status cockpit
```
```
● cockpit.service - Cockpit Web Service
     Loaded: loaded (/usr/lib/systemd/system/cockpit.service; static)
     Active: active (running) since Fri 2024-10-01 16:30:51 UTC; 1min 1s ago
  TriggeredBy: ● cockpit.socket
       Docs: man:cockpit-ws(8)
    Process: 7024 ExecStartPre=/usr/libexec/cockpit-certificate-ensure --for-cockpit-tls (code=exited, status=0/SUCCESS)
  Main PID: 7038 (cockpit-ws)
     Memory: 1.1M
     CGroup: /system.slice/cockpit.service
             └─7038 /usr/libexec/cockpit-ws
Oct 01 16:30:51 fedora systemd[1]: Starting Cockpit Web Service...
Oct 01 16:30:51 fedora systemd[1]: Started Cockpit Web Service.
```
this means that the cockpit service is active and running. Because the socket is enabled, the service started when the traffic came in on the specified port. When we accessed ``localhost:9090`` in the browser, the service started and we were able to access the cockpit service.

Now let's close the browser and check the status of the cockpit service again. It should be inactive because the traffic has stopped. But the status may realize this after a while.

---
#### Timers in Systemd 
let's list all available timers
```bash
systemctl list-units --type=timer
```
This will list all available timers on the system. You can see the status of the timers and the services they are associated with.
for example, the ``dnf-makecache.timer`` is associated with the ``dnf-makecache.service``. You can see the status of the timer and the service it is associated with.
```bash
systemctl cat dnf-makecache.timer
```
```
# /usr/lib/systemd/system/dnf-makecache.timer
[Unit]
Description=Run dnf makecache --timer
ConditionKernelCommandLine=!rd.live.image
# See comments in dnf-makecache.service
ConditionPathExists=!/run/ostree-booted
Wants=network-online.target

[Timer]
OnBootSec=10min
OnUnitInactiveSec=1h
RandomizedDelaySec=60m
Unit=dnf-makecache.service

[Install]
WantedBy=timers.target
```
The ``OnBootSec`` property specifies the time after boot when the timer should be started. The ``OnUnitInactiveSec`` property specifies the time after the unit is inactive when the timer should be started. The ``RandomizedDelaySec`` property specifies the random delay before the timer is started. The ``Unit`` property specifies the service that should be started when the timer is started. The ``WantedBy`` property specifies the target where the timer should be enabled.

---
#### CPU Shares and Weights in Systemd

**!! DO THIS EXAMPLE IN A VM OR A CONTAINER !!**

``/bin/bash -c "while true; do echo -n ''; done"`` is a script is a bash while loop that runs indifiitely. This script will consume CPU resources. ``echo -n ''`` won't produce any output. This means that the script will run indefinitely and consume CPU resources without overwhelming the systemd-journal service.	

- let's have an example of two services with different cpu shares. 

    ```
    [Unit]
    Description=CPU Intensive Service 1

    [Service]
    Type=simple
    ExecStart=/bin/bash -c "while true; do echo -n ''; done"    
    CPUShares=512
    ```
    ```
    [Unit]
    Description=CPU Intensive Service 2
    After=network.target

    [Service]
    Type=simple
    ExecStart=/bin/bash -c "while true; do echo -n ''; done"    
    CPUShares=1024
    ```
    - **CPUShares (Range: 2 to 262144, Default value: 1024)**

      - In our example, Service 1 has 512 shares, and Service 2 has 1024 shares. When both services are demanding CPU, Service 2 will get approximately twice as much CPU time as Service 1.

- let's have the same example with CPU weights

 
    ```
    [Unit]
    Description=CPU Intensive Service 1

    [Service]
    Type=simple
    ExecStart=/bin/bash -c "while true; do echo -n ''; done"    
    CPUWeight=50
    ```
    ```
    [Unit]
    Description=CPU Intensive Service 2
    After=network.target

    [Service]
    Type=simple
    ExecStart=/bin/bash -c "while true; do echo -n ''; done"    
    CPUWeight=100
    ```
  - **CPUWeight (Range: 1 to 10000, Default value: 100)**

    - In our example, Service 1 has weight 50, and Service 2 has weight 100. Similar to CPUShares, Service 2 will get about twice as much CPU time as Service 1 when both are competing for CPU.

Let's add the service files to the system and start the services. 
```bash
sudo cp cpu_intensive_service1.service /etc/systemd/system/
sudo cp cpu_intensive_service2.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl start cpu_intensive_service1
sudo systemctl start cpu_intensive_service2
```
Now let's use ``htop`` or ``top`` to see the CPU usage of the services. 

![Screenshot](/systemd/Screenshot%202024-10-02%20171645.png)

So press F10 to exit and let's deactive the services
```bash
sudo systemctl stop cpu_intensive_service1
sudo systemctl stop cpu_intensive_service2
```
now let's deactivate a cpu core
```bash
# change to root user, since this wouldn't be possible with sudo
su root 
echo 0 > /sys/bus/cpu/devices/cpu1/online
```
this will deactivate the cpu core 1. Now let's see the CPU usage of the services again.

```bash
# going back to our user
su user	
sudo systemctl start cpu_intensive_service1
sudo systemctl start cpu_intensive_service2
```
Now let's use ``top`` to see the CPU usage of the services (for some reason ``htop`` doesn't show the sharing the cpu resources between these two properly)

![Screenshot](/systemd/Screenshot%202024-10-02%20173611.png)

This shows that the CPU shares and weights are working as expected. Service 2 is getting more CPU time than Service 1 because it has more shares and weight.

Let's stop the services and activate the cpu core again
```bash
sudo systemctl stop cpu_intensive_service1
sudo systemctl stop cpu_intensive_service2
sudo rm -rf /etc/systemd/system/cpu_intensive_service1.service
sudo rm -rf /etc/systemd/system/cpu_intensive_service2.service
# change to root user, since this wouldn't be possible with sudo
su root
sudo echo 1 > /sys/bus/cpu/devices/cpu1/online
# going back to our user
su user
```
Now let's see ``htop`` for last time. 
![Screenshot](/systemd/Screenshot%202024-10-02%20174848.png)

Everything is back to normal.

***Note: These services were operating a infinite loop in bash and this is in the ``user slice`` and when we run something in the ``user slice`` again the cpu shares of the services would change and distributed again. Now if we started services from ``system slice`` or the ``machine slice`` the cpu shares of our two services wouldn't chnage since it is in the ``user slice`` and wouldn't be relevant to the services in the ``system slice`` or the ``machine slice``.***

---
#### Managing Dependencies in Systemd
- let's install ``httpd`` and ``vsftpd`` services
```bash
sudo dnf install httpd vsftpd
```
- let's check if the services are loaded but inactive and disabled
```bash
systemctl status httpd
systemctl status vsftpd
```
- then edit the ``httpd`` service configuration file
```bash
sudo systemctl edit httpd
```
then we make ``httpd`` to require ``vsftpd`` service by adding following lines
```
### Anything between here and the comment below will become the new contents of the file
[Unit]
Requires=vsftpd.service
```
- let's check if a ``vsftpd`` service is already running (it shouldn't be)
```bash
ps aux | grep vsftpd
```
- let's start the ``httpd`` service and check if the ``vsftpd`` service is started as well
```bash
sudo systemctl start httpd
ps aux | grep vsftpd
```
and you can see that the ``vsftpd`` service is started as well.

---
#### Self-Healing in Systemd
- let's go to the ``httpd`` service configuration file and add the following lines
```
### Anything between here and the comment below will become the new contents of the file
[Service]
Restart=always
RestartSec=10
```
- let's check the status of the ``httpd`` service
```bash
sudo systemctl status httpd
```
- let's kill the ``httpd`` service
```bash
sudo kill -9 2345 # <httpd_pid>
```
- let's check the status of the ``httpd`` service again
```bash
sudo systemctl status httpd
```
you can see that the service is restarted automatically after 10 seconds. This is the self-healing feature of systemd. The service is restarted automatically when it fails.

---
#### Summary Example
##### Example Description
Configure the ``httpd`` service that is started when traffic comes in on port 80. 
##### Steps
This means using sockets to start the service when traffic comes in on port 80. First take a look at these examples and notes:
-  [Managing Systemd Sockts](/systemd/systemd.md/#managing-systemd-sockts)
- [Managing Sockets in Systemd - Activating Cockpit Socket ](#managing-sockets-in-systemd---activating-cockpit-socket)

- As we did prior configurations on the ``httpd`` service, we will firstly remove the configurations we made
```bash
sudo systemctl stop httpd
```
- let's remove the configurations we made
```bash
sudo rm -rf /etc/systemd/system/httpd.service.d
```
- let's remove the systemd daemon
```bash
sudo systemctl daemon-reload
```
now when we see the ``httpd`` service configuration file, we see that the configurations we previously made are removed.

We don't need the ``restart`` and `restartSec` properties in the service configuration file, because that doesn't make sense with a socket-activated service. The service is started when traffic comes in on port 80, so there is no need to restart the service when it fails.

- let's run the following command to see the sockets and see if there is a socket for the ``httpd`` service
```bash
systemctl list-units --type=socket
```
and we see that there is already a httpd socket.

- let's overview sockets related to the ``httpd`` service
```bash
systemctl cat httpd.socket
```
and we see this
```
[Socket]
ListenStream=80
NoDelay=true
DeferAcceptSec=30
```
we can see that the ``httpd`` service is started when traffic comes in on port 80. The ``ListenStream`` property specifies the IP address and port number on which the socket should listen for TCP traffic. The ``NoDelay`` property specifies that the socket should not delay sending data. The ``DeferAcceptSec`` property specifies the time to wait before accepting a connection.

- let's enable the ``httpd`` socket
```bash
sudo systemctl enable httpd.socket
```

- let's send something over port 80 to start the ``httpd`` service. (it may need root privileges)
```bash
echo "Hello World" > /var/www/html/index.html
```
now since we have the ``httpd`` service socket enabled, when we send traffic to port 80, the ``httpd`` service will start automatically.
```bash
curl http://localhost:80
```
this will return the content of the ``index.html`` file.
```
Hello World!
```
this means that the ``httpd`` service is started when traffic comes in on port 80. This is how you can configure a service to start when traffic comes in on a specific port.

```bash
sudo systemctl status httpd
```
we see in the status this line:
```
TriggeredBy: ● httpd.socket
```
this means that the ``httpd`` service is started when traffic comes in on port 80.