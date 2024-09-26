# Networking in Linux Summary
For more detailed please read this:
- [Networking in Linux](/3-linux-operations-basics/1-networking/networking.md)

## Summary
### ``IPv4`` and ``IPv6``
- ``IPv4`` is the fourth version of the Internet Protocol (IP) and is the first version of the protocol to be widely deployed. 
- It uses 32-bit addresses, which limits the number of unique addresses to 4.3 billion.
- ``IPv6`` is the most recent version of the Internet Protocol (IP), the communications protocol that provides an identification and location system for computers on networks and routes traffic across the Internet. It uses uses 128-bit addresses and hexadecimal representation. e.g., `2001:0db8:85a3:0000:0000:8a2e:0370:7334`
    - in each group can be omitted.
        - e.g., `2001:0db8:85a3:0000:0000:8a2e:0370:7334` can be written as `2001:db8:85a3:0:0:8a2e:370:7334`
    - A double colon `::` can be used to represent multiple groups of zeros.
        - e.g., `2001:0db8:85a3:0000:0000:8a2e:0370:7334` can be written as `2001:db8:85a3::8a2e:370:7334`
    - In IPv6 `[address]:port` is used to specify the port number. e.g., `[2001:db8:85a3::8a2e:370:7334]:80`
    - IPv6 has reserved addresses for special purposes.
        - e.g., `::1` for the loopback address, `::` for the unspecified address, etc.
        - ``::1/128`` is the localhost address.
        - ``::/0`` is the default route.
        - ``2000::/3`` is the global unicast address space.
        - ``fd00::/8`` is the unique local address space.
        - ``fe80::/64`` is the link-local address space.
        - ``ff00::/8`` is the multicast address space.
#### ``DHCP`` and ``DHCPv6``
- ``DHCP`` is a network management protocol used on Internet Protocol networks whereby a DHCP server dynamically assigns an IP address and other network configuration parameters to each device on a network so they can communicate with other IP networks.
- ``DHCPv6`` is a version of DHCP for IPv6 networks.
#### ``SLAAC``
- ``SLAAC`` is a method in IPv6 for autoconfiguration of hosts. It is stateless, meaning that the host does not need to obtain or renew a lease for the IP address.
##### ``radvd``
- ``radvd`` is the tool used to advertise the IPv6 prefix to the network.
### ``ip`` Command
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

### Managing Hostnames
| utility or file | Description |
| --- | --- |
| ``hostnamectl`` | Query and change system hostname |
| ``/etc/hosts`` | Map IP addresses to hostnames |
| ``/etc/resolv.conf`` | Configure DNS settings |
| ``/etc/nsswitch.conf`` | Configure the order of host resolution |


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
### Netwrorking Tools
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

### Persistent Network Configuration
- Network Manager is a service that manages network connections and persists network configurations.
- ``nmtui`` is a text-based user interface for Network Manager and is a simple and easy-to-use tool for configuring network settings.
- ``nmcli`` is a command-line interface for Network Manager and is a powerful tool for configuring and managing network settings and is intended for advanced users.
#### Useful Guides
- [Configuring IP Networking with nmtui - Redhat](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/7/html/networking_guide/sec-configuring_ip_networking_with_nmtui)
- [nmcli](https://www.networkmanager.dev/docs/api/latest/nmcli.html)
- [nmcli cheatsheet](https://www.golinuxcloud.com/nmcli-command-examples-cheatsheet-centos-rhel/)
- [Using nmcli - Beginners Guide](https://raspberrytips.com/nmcli-linux-command/)