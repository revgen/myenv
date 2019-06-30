#!/bin/sh
echo "============================================================"
tools="vim-gnome gnome-terminal xarchiver evince"
echo "Install core linux tools: ${tools}"
sudo apt-get install $(echo ${tools} | sed 's/,/ /g')

echo "Done"

