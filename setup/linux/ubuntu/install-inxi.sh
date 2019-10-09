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
sudo apt-get -y install dnsutils hddtemp lm-sensors tree upower 
sudo apt-get -y install libcpanel-json-xs-perl libjson-xs-perl

echo "---------------------"
echo "Check sensors"
sudo sensors-detect --auto
sensors

echo "---------------------"
echo "Check inxi tool"
inxi -mF

echo "--[End: $(basename "${0}")  ]-----------------"
