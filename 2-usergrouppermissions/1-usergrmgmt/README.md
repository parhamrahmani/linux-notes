# Summary of user group management
![User Group Management](users.drawio.png)
## Permissions
example:
```
 -rw-r--r--
```
- first character: file type
- next section: owner permissions
- next section: group permissions
- next section: other permissions
- ```r``` = read, ```w``` = write, ```x``` = execute

## User & Group Management Summary

| Command                              | Description                                           |
|--------------------------------------|-------------------------------------------------------|
| `id`             | Displays user ID, group ID, and group memberships. |
| `uid`       | Unique identifier for the user.                  |
| `gid`       | Primary group identifier for the user.           |
| Permissions | File access rights for owner, group, and others. |
| `sudo useradd -m -s /bin/bash newuser` | Create a new user with a home directory and default shell. |
| `sudo passwd newuser`                | Set the password for the new user.                    |
| `grep newuser /etc/passwd`           | Check user info in passwd           |
| `useradd -D`                         | Get an overview of currently effective default settings. |
| `sudo userdel -rf newuser`           | Delete a user and remove their home directory and mail spool. |
| `sudo groupadd newgroup`             | Create a new group.                                   |
| `sudo usermod -aG newgroup newuser`  | Add a user to a group.                                |
| `grep newgroup /etc/group`           | Check group details.                                  |
| `groupdel newgroup`                  | Delete a group.                                       |
| `groupmod -n newgroup2 newgroup`     | Change the group name.                                |
| `groupmod -p newpassword newgroup2`  | Change the group password.                            |

### Properties for `useradd` using ``useradd -D``

| Setting            | Description                                           |
|--------------------|-------------------------------------------------------|
| `GROUP`            | Default group ID                                      |
| `HOME`             | Default home directory                                |
| `INACTIVE`         | Number of days after the password expires             |
| `EXPIRE`           | Date when the account expires                         |
| `SHELL`            | Default shell                                         |
| `SKEL`             | Directory containing default files                    |
| `CREATE_MAIL_SPOOL`| Whether to create a mail spool file                   |

### Managing Users and Groups Properties
| Property       | Description                                      |
|----------------|--------------------------------------------------|
| `uid`          | User ID                                          |
| `gid`          | Group ID (primary group)                         |
| `gecos`        | User information, comments (optional)            |
| `home`         | Home directory                                   |
| `shell`        | Default shell (bash, zsh, etc.)                  |
| `getent passwd username` | View user properties in `/etc/passwd` file |
| `/etc/shadow`  | File where passwords are stored                  |
| `vipw`         | Edit `/etc/passwd` and `/etc/shadow` files directly |
| `/etc/group`   | File where group properties are stored           |
| `vigr`         | Edit `/etc/group` and `/etc/gshadow` files directly |
| `useradd -D`           | Get overview of currently effective default settings |
| `/etc/login.defs`      | Default settings for `useradd` and `usermod` commands |
| `/etc/skel`            | Default files copied to new user's home directory |

### `/etc/passwd` File Fields
  
 ``username:password:uid:gid:gecos:home:shell``
| Field          | Description                                      |
|----------------|--------------------------------------------------|
| `username`     | User name                                        |
| `password`     | Password (x means stored in `/etc/shadow`)       |
| `uid`          | User ID                                          |
| `gid`          | Group ID                                         |
| `gecos`        | User information                                 |
| `home`         | Home directory                                   |
| `shell`        | Default shell                                    |


example:
```
userex:x:1001:1001::/home/userex:/bin/bash
```

## Managing Passwords
| Command                              | Description                                           |
|--------------------------------------|-------------------------------------------------------|
| `passwd`                            | Change your password.                                 |
| `passwd username`                   | Change another user's password.                       |
| `passwd -S username`                | View password properties                              |
| `chage -l username`                 | View password expiration information.                  |
| `chage username`                    | Change password expiration information.                |

- changing password non-interactively

- `echo "newpassword" | sudo passwd --stdin username` Change password non-interactively. In Redhat 
- `echo "username:newpassword" | chpasswd` Change password non-interactively. In Debian

## Session Management Summary

| Command                          | Description                                      |
|----------------------------------|--------------------------------------------------|
| `who`                            | See the users currently logged in.               |
| `w`                              | See the users currently logged in.               |
| `loginctl`                       | Manage user sessions.                            |
| `loginctl list-sessions`         | List all the sessions.                           |
| `loginctl show-session sessionID`| Show the details of a specific session.          |
| `loginctl terminate-session sessionID` | Terminate a specific session.            |
| `loginctl show-user username`    | Show the details of a specific user.             |
| `loginctl kill-user username`    | Terminate all the sessions of a specific user.   |
