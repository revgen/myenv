#!/bin/bash

sudo apt install -y xrdp
# The next packages need to fix a problem wwith blue screen on Ubuntu 18.04
sudo apt install -y xorgxrdp-hwe-18.04


sudo sed -i 's/allowed_users=console/allowed_users=anybody/' /etc/X11/Xwrapper.config

# Fix problem with permission to create a new color profile
echo -e "[Allow Colord all Users]
Identity=unix-user:*
Action=org.freedesktop.color-manager.create-device;org.freedesktop.color-manager.create-profile;org.freedesktop.color-manager.delete-device;org.freedesktop.color-manager.delete-profile;org.freedesktop.color-manager.modify-device;org.freedesktop.color-manager.modify-profile
ResultAny=no
ResultInactive=no
ResultActive=yes
" | sudo tee /etc/polkit-1/localauthority/50-local.d/color.pkla

# Install Extensions Dock...
sudo apt install gnome-tweak-tool
gnome-shell-extension-tool -e ubuntu-dock@ubuntu.com
gnome-shell-extension-tool -e ubuntu-appindicators@ubuntu.com

sudo rm /var/crash/*

sudo systemctl restart xrdp.service


# Enable Audio throw RDP on Ubuntu 18.04

On the Ubuntu 18.04 you should build Pusleaudio module for xrdp from the source code

```bash
sudo apt-get install xrdp-pulseaudio-installer  -y

# sudo xrdp-build-pulse-modules - that command will show an error: something like - cannot open pulseaudio directory
# We need to build pulseaudio from source:
# Enable source repository for apt (uncomment all deb-src lines):
sudo vim /etc/apt/sources.list

sudo apt update

# Downloade and coonfigure Pulseaudio sources
cd /tmp
sudo apt source pulseaudio
cd /tmp/pulseaudio*
sudo ./configure

# Building module
cd /usr/src/xrdp-pulseaudio-installer
sudo make PULSE_DIR="/tmp/pulseaudio-11.1"

# Installing the Pulseaudio module
ls -ahl *.so
sudo install -t "/var/lib/xrdp-pulseaudio-installer" -D -m 644 *.so
# Show Pulseaudio module
ls -ahl /var/lib/xrdp-pulseaudio-installer
```

Restart the computer (maybe logout/login will be enough)

To test xrdp Pulseaudio module:
* Open Settings
* Open Sound
* In Output devices you shuld see: **xrdp sink**

# Full source: https://c-nergy.be/blog/?p=12469

