#!/bin/bash

sudo apt installl -y evince xdotool wmctrl xclip simple-scan remmina keepassxc gparted
sudo apt install mplayer ffmpeg youtube-dl kid3
sudo apt install -y lightdm lightdm-gtk-greeter-settings

if [ -n "$(grep "^NAME" /etc/os-release | grep -i "ubuntu")" ]; then
    # ubuntu specific tools
    sudo apt install -y gnome-sound-recorder dconf-tools gnome-tweaks
    sudo apt purge -y gnome-software
    sudo apt purge gdm3
fi

sudo apt-get install blueman
sudo apt install libreoffice-calc libreoffice-writer
