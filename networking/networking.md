# Networking
## Contents:
- [IPv4](#ipv4)
- [IPv6](#ipv6)
- [IP Address Configuration](#ip-adress-configuration)
    - [``ip`` Command](#ip-command)
- [Network Device Naming](#network-device-naming) 
    - [Manafing Names](#managing-hostnames) 
- [Network Tools](#network-tools)
- [Persistent Network Configurations](#persistent-network-configurations)
- [Summary](/3-linux-operations-basics/1-networking/README.md)
  

## IPv4 and IPv6
### IPv4
- IPv4 is the fourth version of the Internet Protocol.
- It uses 32-bit addresses, which limits the number of unique addresses to 4.3 billion.

#### Routers
- Routers are devices that connect different networks together.
- They use IP addresses to determine where to send packets.
- They can be physical devices or software-based.
    - e.g., Cisco, Juniper, MikroTik, etc.

#### Nodes
- Nodes are devices that are connected to a network.
- They can be computers, servers, or any other device that can connect to a network.
- They use IP addresses to communicate with each other.

#### Domain Name System (DNS)
- DNS is a system that translates domain names to IP addresses.
- It helps users access websites using human-readable names.

##### DNS Servers
- DNS servers are servers that store domain name records.
- They help resolve domain names to IP addresses.
    - e.g., Google DNS, Cloudflare DNS, etc.

#### Subnetting
- Subnetting is the process of dividing a network into smaller subnetworks.
- It helps reduce network congestion and improve security.
- It is done by changing the subnet mask of a network.
    - e.g., `255.255.255.0` for a Class C network.

#### Network Address Translation (NAT)
- NAT is a method used to remap one IP address space into another.
- It modifies network address information in IP packet headers while in transit.
- It helps improve security and decrease the number of IP addresses an organization needs.

#### IPv4 Address Classes
- IPv4 addresses are divided into five classes (A, B, C, D, E).
- Each class has a different range of IP addresses and is used for different purposes.
    - Class A: `1.0.0.0` to `126.0.0.0`
    - Class B: `128.0.0.0` to `191.255.0.0`
    - Class C: `192.0.0.0` to `223.255.255.0`
    - Class D: `224.0.0.0` to `239.255.255.255` (Multicast)
    - Class E: `240.0.0.0` to `255.255.255.255` (Experimental)

#### Private IP Addresses
- Private IP addresses are used within a private network and are not routable on the internet.
- They are defined in the following ranges:
    - Class A: `10.0.0.0` to `10.255.255.255`
    - Class B: `172.16.0.0` to `172.31.255.255`
    - Class C: `192.168.0.0` to `192.168.255.255`

#### Broadcast and Multicast
- **Broadcast**: Sending a packet to all devices in a network.
    - e.g., `255.255.255.255` for local network broadcast.
- **Multicast**: Sending a packet to a group of devices.
    - e.g., `224.0.0.0` to `239.255.255.255` for multicast addresses.

#### IPv4 Exhaustion
- IPv4 address exhaustion refers to the depletion of available IPv4 addresses.
- This has led to the development and deployment of IPv6, which uses 128-bit addresses.

#### Transition to IPv6
- IPv6 is the successor to IPv4 and provides a vastly larger address space.
- It uses 128-bit addresses, allowing for a virtually unlimited number of unique addresses.
- Transition mechanisms include dual-stack, tunneling, and translation techniques.

### IPv6
- IPv6 is the sixth version of the Internet Protocol.
- It uses 128-bit addresses, which allows for a significantly larger number of unique addresses. written in hexadecimal.
- It was developed to address the limitations of IPv4.
    - e.g., `2001:0db8:85a3:0000:0000:8a2e:0370:7334`
#### Omiting Zeros
- Leading zeros in each group can be omitted.
    - e.g., `2001:0db8:85a3:0000:0000:8a2e:0370:7334` can be written as `2001:db8:85a3:0:0:8a2e:370:7334`
- A double colon `::` can be used to represent multiple groups of zeros.
    - e.g., `2001:0db8:85a3:0000:0000:8a2e:0370:7334` can be written as `2001:db8:85a3::8a2e:370:7334`
#### Addressing Ports
- In IPv6 `[address]:port` is used to specify the port number. e.g., `[2001:db8:85a3::8a2e:370:7334]:80`

#### Reserved Addresses
- IPv6 has reserved addresses for special purposes.
    - e.g., `::1` for the loopback address, `::` for the unspecified address, etc.
    - ``::1/128`` is the localhost address.
    - ``::/0`` is the default route.
    - ``2000::/3`` is the global unicast address space.
    - ``fd00::/8`` is the unique local address space.
    - ``fe80::/64`` is the link-local address space.
    - ``ff00::/8`` is the multicast address space.

#### Transition Mechanisms
##### Obtaining IPv6 Addresses
###### Static Address Configuration
- Static configuration involves manually assigning an IPv6 address to a device.
###### DHCPv6
- DHCPv6 is a protocol used to automatically assign IPv6 addresses to devices.
- It is similar to DHCP for IPv4 but uses different messages and options.
- Multicast is sent to `ff02::1:2` on port `547` udp. The DHCP server sends a unicast response to the client on port `546` udp.
###### Stateless Address Autoconfiguration (SLAAC)
- SLAAC is a method used to automatically configure IPv6 addresses on devices.
- It uses the Neighbor Discovery Protocol (NDP) to obtain network information.
- Router solicitation is sent to `ff02::2`. The all-router multicast address is `ff02::2` ans it sends back an IP address to the client and the host learns the netwrok prefix. 
    - package ``radvd`` is used in linux to send router advertisements.

### IP Adress Configuration
- On Servers, IP addresses are set statically. Tools such as ``nmcli`` or ``nmtui`` can be used to configure IP addresses.
- On Desktops, IP addresses are usually obtained dynamically using a ``DHCP`` server.
-  ``ip`` can be used to configure and troubleshoot IP addresses in Linux. 
     - **Note**: ``ifconfig`` is deprecated and ``ip`` is the modern tool for network configuration. ``ifconfig`` is not installed by default in many distributions and shouldn't be used.
#### ``ip`` Command
| Command | Description |
| --- | --- |
| ``ip addr show`` | Show IP addresses |
| `` ip a`` | Show IP addresses |
| ``ip addr add dev <interface> <ip-address>/<subnet-mask>`` | Add an IP address of a device to an interface |
| ``ip addr del dev <interface> <ip-address>/<subnet-mask>`` | Delete an IP address of a device from an interface |
| ``ip link show`` | Show network interfaces |
| ``ip link set <interface> up`` | Enable a network interface |
| ``ip link set <interface> down`` | Disable a network interface |
| ``ip route show`` | Show routing table |
| ``ip route add default via <gateway-ip>`` | Add a default route |
##### Examples
- Show IP addresses:
    ```bash
    ip addr show
    ```
- Add an IP address to an interface:
    ```bash
    sudo ip addr add dev ens33 10.0.0.10/24
    ```
- Verify the IP address is added:
    ```bash
    ip addr show ens33
    ```
- Enable a network interface:
    ```bash
    sudo ip link set ens33 up
    ```
- Show the routing table:
    ```bash
    ip route show
    ```
## Network Device Naming
### Naming Based on Network Device Type
e.g.
- ``eth``: Ethernet devices
- ``wlan``: Wireless LAN devices
### Naming Based on Physical Location
e.g.
- ``enp0s3``: Ethernet device on PCI bus 0, slot 3
- ``wlx74da38f7a1d6``: Wireless LAN device with MAC address `74:da:38:f7:a1:d6`
### Biosdevname
- ``biosdevname`` is a utility that assigns predictable names to network devices based on BIOS information and reveal the physical location of the device.
#### ``systemd-udevd``
- ``systemd-udevd`` is a device manager for the Linux kernel and is responsible for device naming (Biosdevname).
#### Some Examples
- ``em1``: Embedded Ethernet device on PCI bus 1. (em123 Ethernet Motherboard Port Number)
- ``p4p1``: PCI bus 4, port 1. (``p<port>p<slot>``)
- ``eno1``: Embedded Ethernet device on PCI bus 0, slot 1. (eno123 Ethernet Onboard Number)
- ``eth0``:When driver doesn't provide or reveal enough information. 
### Managing Hostnames
- Hostnames are used to identify devices on a network.
- host name resolution is required as often reserved host name lookups are performed in communication between hosts. 
#### ``hostnamectl``
- ``hostnamectl`` is a command-line utility for querying and changing system hostname.
- It is used to set the hostname of a system.
- needs the system to be booted with ``systemd``.
#### ``/etc/hosts``
- The ``/etc/hosts`` file is used to map IP addresses to hostnames.
- It is used to resolve hostnames locally. On the internet, DNS servers are used.
#### Examples
- Show the current hostname:
    ```bash
    hostnamectl
    ```
- enable hostname resolution using ``/etc/hosts``:
    ```bash
    sudo vim /etc/hosts
    ```
    - Add the following line:
        ```
        192.168.29.141 server1.example.com server1
        ```
### ``etc/resolv.conf``
- The ``/etc/resolv.conf`` file is used to configure DNS settings.
- It contains the IP addresses of DNS servers that the system should use.
### ``/etc/nsswitch.conf``
- The ``/etc/nsswitch.conf`` file is used to configure the order of host resolution.
- It specifies the order in which different sources should be queried to resolve hostnames.
#### Example
- Show the contents of the ``/etc/nsswitch.conf`` file:
    ```bash
    sudo vim /etc/nsswitch.conf
    ```
    and you can see this line:
    ```
    hosts:      files dns myhostname
    ```
    - This line specifies that the system should first look in the ``/etc/hosts`` file, then query DNS servers, and finally use the system hostname.
    - For example let's ping a website:
        ```bash
        ping google.com
        ```
        - The system first checks the ``/etc/hosts`` file, then queries the DNS server specified in the ``/etc/resolv.conf`` file.
        - If the hostname is not found in either location, the system uses the hostname specified in the ``/etc/hostname`` file.
    - let's add ``google.com`` to the ``/etc/hosts`` file:
        ```bash
        sudo vim /etc/hosts
        ```
        - Add the following line:
            ```
           192.168.29.141 server1.example.com server1 google.com
            ```
        - Now, when you ping ``google.com``, the system will resolve the IP address from the ``/etc/hosts`` file.

## Network Tools
| Tool | Description |
| --- | --- |
| ``ping`` | Send ICMP echo requests to a host |
| ``ping -c <count>`` | Send a specific number of packets |
| ``ss`` | Show socket statistics |
| ``ss -tunap`` | Show TCP, UDP, and Unix socket statistics |
| ``dig`` | DNS lookup utility |
| ``nmap`` | Network scanning tool |
| ``netstat`` | Show network statistics - *deprecated* replaced by ``ss`` |
| ``nslookup`` | Query DNS servers for information - *deprecated* replaced by ``dig`` |

## Persistent Network Configurations
### Network Manager
- Network Manager is a service that manages network connections and persists network configurations.
- ``nmtui`` is a text-based user interface for Network Manager and is a simple and easy-to-use tool for configuring network settings.
- ``nmcli`` is a command-line interface for Network Manager and is a powerful tool for configuring and managing network settings and is intended for advanced users.
#### Useful Guides
- [Configuring IP Networking with nmtui - Redhat](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/7/html/networking_guide/sec-configuring_ip_networking_with_nmtui)
- [nmcli](https://www.networkmanager.dev/docs/api/latest/nmcli.html)
- [nmcli cheatsheet](https://www.golinuxcloud.com/nmcli-command-examples-cheatsheet-centos-rhel/)
- [Using nmcli - Beginners Guide](https://raspberrytips.com/nmcli-linux-command/)

## More on Networking
