#!/bin/bash

sudo apt install -y xdotool wmctrl xclip
sudo apt install -y mplayer ffmpeg webp imagemagick youtube-dl kid3 pinta
sudo apt install remmina gparted
# sudo apt-get install -y mtpaint
# sudo apt-get install -y mypaint   - good for painter
# sudo apt-get install -y xarchiver
# sudo apt-get install -y evince
# sudo apt-get install -y encfs


sudo apt install vim-gnome
sudo apt install keepassxc
sudo apt install simple-scan
sudo apt install -y lightdm lightdm-gtk-greeter-settings
sudo apt install blueman
sudo apt install libreoffice-calc libreoffice-writer

if [ -n "$(grep "^NAME" /etc/os-release | grep -i "ubuntu")" ]; then
    # ubuntu specific tools
    sudo apt install -y dconf-tools
    sudo apt install -y gnome-sound-recorder
    sudo apt install -y gnome-tweaks
    sudo apt install -y gnome-tweak-tool

    sudo apt purge -y gnome-software
    sudo apt purge -y pluma
    sudo apt purge -y xchat
    sudo apt purge -y brasero
    sudo apt purge gdm3
fi

