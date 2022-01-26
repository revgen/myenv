#!/bin/sh
sudo apt-get -y clean
sudo apt-get -y autoclean
sudo apt-get -y autoremove
sudo rm -rvf /var/lib/apt/lists/*
sudo rm -f   /var/cache/apt/*.bin
sudo rm -rvf /var/cache/apt/archives
