#!/bin/sh

install xdotool
install xubuntu-restricted-extras

echo "============================================================"
tools="xfce4-terminal parole keepassx evince"
echo "Install core linux tools: ${tools}"
sudo apt-get install $(echo ${tools} | sed 's/,/ /g')

echo "Done"

