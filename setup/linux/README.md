# Linux settings, tools and applications

Directory contains scripts and manuals for linux system based on Ubuntu OS.

* [System settings](#system-settings)
* [SSH settings](#ssh-settings)
* [Notes](#notes)

## System settings

### Text mode settings
```bash
sudo dpkg-reconfigure console-setup
- UTF-8
- Cyrillic (Slavic)
- Terminus
- 12x6 or 8x14
```

## SSH settings

### Generate ssh keys and copy public key to the server

```bash
ssh-keygen -f <server-name>
ssh-copy-id -i ~/.ssh/<serveer-name>.pub <server-name>
```

Check cnnection with key

```bash
ssh <server-name>
```

### Configuration

```bash
sudo vim /etc/ssh/sshd_config
```

Restrict root connection:
```bash
PermitRootLogin no
```

Access by key only:
```bash
PermitEmptyPasswords no
PasswordAuthentication no
```

Who can use:

```bash
AllowUsers user1 user2
AllowGroup group1 group2
```

### Enable two-factor auth for SSH connection (draft - not tested) 
1. sudo apt install google-authenticator
2. sudo google-authenticator
3. sudo vi /etc/pam.d/sshd
    ```
    # add new line
    auth required pam_google_authenticator.so
    ```
4. sudo vi /etc/ssh/sshd_config
    ```
    # add new line:
    ChallengeResponseAuthentication yes
    ```
5. systemctl restart sshd


## Notes:

Set immutable flag to the file (after that the file can't be updated):
```bash
chattr +i /path/to/file
```

Remove the flag:
```bash
chattr -i /path/to/file
```
