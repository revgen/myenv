# Linux settings, tools and applications

Directory contains scripts and manuals for linux system based on Ubuntu OS.

## Text mode settings

    sudo dpkg-reconfigure console-setup
    - UTF-8
    - Cyrillic (Slavic)
    - Terminus
    - 12x6 or 8x14


## SSH settings
sudo vim /etc/ssh/sshd_config

Restrict root connection:

    PermitRootLogin no

Access by key only:

    PermitEmptyPasswords no
    PasswordAuthentication no

Who can use:

    AllowUsers user1 user2
    or
    AllowGroup group1 group2


### Enable two-factor auth for SSH connection (draft - not tested) 
1. sudo apt install google-authenticator
2. sudo google-authenticator
3. sudo vi /etc/pam.d/sshd
    # add new line
    auth required pam_google_authenticator.so
4. sudo vi /etc/ssh/sshd_config
    # add new line:
    ChallengeResponseAuthentication yes
5. systemctl restart sshd


## Notes:

Set immutable flag to the file (after that the file can't be updated):

    chattr +i /path/to/file

Remove the flag:

    chattr -i /path/to/file


