#!/bin/sh
echo "Remove unused modules and headers"
dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' | xargs sudo apt -y purge

echo "Remove sources from /usr/src/*"
sudo rm -rf /usr/src/*

