#!/bin/sh
sudo apt-get clean
sudo apt-get autoclean
sudo apt-get autoremove
sudo rm -rvf /var/lib/apt/lists/*
sudo rm /var/cache/apt/*.bin
sudo rm -rvf  /var/cache/apt/archives
