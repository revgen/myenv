# Update TTY screen

To display messages before and after the login process, Linux uses the [/etc/issue](https://man7.org/linux/man-pages/man5/issue.5.html)
 and the [/etc/motd](https://man7.org/linux/man-pages/man5/motd.5.html) files.

These messages are global. These messages will display to all users at the CLI prompt.

To display a customized message before login, you need to edit /etc/issue file.

```bash
# Backup existing (original) files
[ ! -f /etc/issue.orig ] && sudo cp -v /etc/issue /etc/issue.orig

# Update a issue file
(
echo "[\l] $(grep "^PRETTY_NAME" /etc/os-release | cut -d"=" -f2 | sed 's/"//g')"
echo ""
echo "hostname: \n"
echo "ethernet: \4{eth0}"
echo "wireless: \4{wlan0}"
echo ""
) | sudo tee /etc/issue
```

The example outut after update:

```
[tty1] Ubuntu 24.04 LTS 
hostname: MyHost
ethernet: 192.168.1.5
wireless: 192.168.1.150
```

The /etc/motd file is generally used to display an issue, security policy, or message.
