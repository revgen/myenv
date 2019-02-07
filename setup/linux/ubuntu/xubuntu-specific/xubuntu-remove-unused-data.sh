#!/bin/sh

echo "================================================"
echo "Remove unused packages"
#sudo apt-get purge -y xterm software-properties-gtk update-manager
sudo apt-get purge -y synaptic
sudo apt-get purge -y blueman
sudo apt-get purge -y bluez bluez-obexd bluez-cups
sudo apt-get purge -y parted gucharmap
sudo apt-get purge -y hplip hplip-data
sudo apt-get purge -y hexchat transmission-common transmission-gtk parole mugshot pidgin
sudo apt-get purge -y simple-scan parole gnome-mines gnome-sudoku mugshot
sudo apt-get purge -y xfce4-weather-plugin xfce4-power-manager-plugins xfce4-dict xfce4-systemload-plugin
sudo apt-get purge -y xfce4-verve-plugin xfce4-cpugraph-plugin xfce4-mailwatch-plugin xfce4-netload-plugin

echo "================================================"
echo "Remove unused xubuntu files"
sudo rm -rf /usr/share/gnome/help/*
sudo rm -rf /usr/share/xubuntu-docs

sudo rm -rf /usr/share/hplip
sudo rm -rf /usr/share/app-install/desktop
sudo rm -rf /usr/share/xfce4/backdrops/*
sudo rm -rf /usr/share/wallpapers/*

