#!/bin/bash

sudo apt install -y xrdp
# The next packages need to fix a problem wwith blue screen on Ubuntu 18.04
# sudo apt install -y xorgxrdp-hwe-18.04

sudo sed -i 's/allowed_users=console/allowed_users=anybody/' /etc/X11/Xwrapper.config

# Fix problem with permission to create a new color profile
echo -e "[Allow Colord all Users]
Identity=unix-user:*
Action=org.freedesktop.color-manager.create-device;org.freedesktop.color-manager.create-profile;org.freedesktop.color-manager.delete-device;org.freedesktop.color-manager.delete-profile;org.freedesktop.color-manager.modify-device;org.freedesktop.color-manager.modify-profile
ResultAny=no
ResultInactive=no
ResultActive=yes
" | sudo tee /etc/polkit-1/localauthority/50-local.d/color.pkla

# Fix the error "/var/log/xrdp.log - cannot read /etc/xrdp/key.pem. Permission denied error explained"
sudo adduser xrdp ssl-cert

echo "Use xfce in rdp session"
echo xfce4-session >~/.xsession

sudo rm /var/crash/*
sudo systemctl restart xrdp.service


