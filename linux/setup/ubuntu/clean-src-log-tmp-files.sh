#!/bin/sh
echo "Remove source files"
sudo rm -rvf /usr/src/*

echo "Clean remporary directories"
sudo rm -rvf /tmp/* /var/tmp/*

echo "Remove logs"
sudo rm -rvf /var/log/*



