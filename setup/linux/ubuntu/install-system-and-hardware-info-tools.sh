#!/bin/bash
echo "--[Begin: $(basename "${0}")]-----------------"
echo "---------------------"
tools="lm-sensors,hddtemp"
echo "Install additional monitoring tools: ${tools}"
sudo apt-get -y install $(echo ${tools} | sed 's/,/ /g')
sudo sensors-detect --auto

echo "---------------------"
echo "Check sensors"
sensors

echo "---------------------"
echo "Install inxi tool"
sudo apt-get -y install inxi
if [ $? -eq 100 ]; then
    echo "- Download tool directly from the site"
    wget -O /tmp/inxi smxi.org/inxi && chmod +x /tmp/inxi \
    && sudo mv -v /tmp/inxi /usr/local/bin
fi

echo "Check inxi tool"
inxi -F

echo "--[End: $(basename "${0}")  ]-----------------"
