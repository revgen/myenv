# Linux CLI: Security

Tools: adduser, usermod, passwd, chpasswd

## Groups

Create Groups
```bash
sudo groupadd <groupname>
```

## Users

Create user
```bash
sudo adduser <username>
```

Create user (quiet mode)
```bash
sudo adduser --ingroup <user main group> --gecos --quiet --disabled-password <username>
```

Update password for user
```bash
passwd <username>
```

Update password for user (quiet mode)
```bash
echo "<username>:<password>" | chpasswd
```

Add user to the specific group
```bash
sudo usermod -aG <groupname> <username>
```

## System settings

### Command: chmod

#### Permissions by letters:
|---------------|---------------|---------------|-----------|
| u - user      | g - group     | o - other     | a - all   |
| r - read      | w - write     | x - execute   |           |
|---------------|---------------|---------------|-----------|

Operation
* '+' - add permission (allow)
* '-' - remove permission (forbid)
* '=' - overwrite all permissions with this one

Examples:
|-----------------------|-----------------------------------------------------|
| chmod g+w hello.c     | allow group to make a changes in a file             |
| chmod a-wx a.out      | forbid writing and executing for everyone           |
| chmod go=rw b.txt     | not an owner user can read and write                |
|-----------------------|-----------------------------------------------------|

#### Permissions by numbers:
|-----------------------|-----------------------------------------------------|
| 0 - forbid everything | (--- = 000)                                         |
| 4 - read only         | (r-- = 100)                                         |
| 5 - read and execute  | (r-x = 101)                                         |
| 6 - read and write    | (rw- = 110)                                         |
| 7 - allow everything  | (rwx = 111)                                         |
|-----------------------|-----------------------------------------------------|

Examples:
|-----------------------|-----------------------------------------------------|
| chmod 660 hello.c     | owner and group can read and write a file           |
| chmod 555 a.out       | everybody can read and execute a file               |
| chmod 777 b.txt       | full access on a file for everybody                 |
|-----------------------|-----------------------------------------------------|

### Allow shutdown for user
```bash
sudo -E visudo
```
Write into the file:
```
# User alias specification
User_Alias USERS = user1, user2, user3
# Cmnd alias specification
Cmnd_Alias SHUTDOWN_CMDS = /sbin/shutdown, /sbin/reboot, /sbin/halt

%admin ALL=(ALL) ALL
USERS ALL=(ALL) NOPASSWD: SHUTDOWN_CMDS
```
