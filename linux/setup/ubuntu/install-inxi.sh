#!/bin/bash
echo "--[Begin: $(basename "${0}")]-----------------"
echo "Install inxi tool"
wget -O /tmp/inxi https://raw.githubusercontent.com/smxi/inxi/master/inxi
chmod +x /tmp/inxi
sudo mv /tmp/inxi /usr/local/bin/

wget -O /tmp/inxi.1 https://raw.githubusercontent.com/smxi/inxi/master/inxi.1
gzip /tmp/inxi.1
sudo mv /tmp/inxi.1.gz /usr/share/man/man1/

echo "---------------------"
echo "Install dependencies"
sudo apt install -y tree
sudo apt install -y acpi 
sudo apt install -y dnsutils
sudo apt install -y hddtemp
sudo apt install -y lm-sensors
sudo apt install -y upower 
sudo apt install -y libcpanel-json-xs-perl libjson-xs-perl

echo "---------------------"
echo "Check sensors"
sudo sensors-detect --auto
sensors

echo "---------------------"
echo "Check inxi tool"
inxi -mF

echo "--[End: $(basename "${0}")  ]-----------------"
