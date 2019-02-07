#!/bin/sh
echo "--[Begin: $(basename "${0}")]-----------------"
echo "Install glaces to the system"
sudo pip3 install bottle glances && \
echo "Create glances.service file" && \
echo -e "[Unit]
Description=Glances
After=network.target

[Service]
ExecStart=/usr/local/bin/glances -w
Restart=on-abort

[Install]
WantedBy=multi-user.target
" > /tmp/glances.service && \
echo "Put it to the system -> /etc/systemd/system/glances.service" && \
sudo mv /tmp/glances.service /etc/systemd/system/glances.service && \
echo "Enable unit for automatic start while booting..." && \
sudo systemctl enable glances.service && \
echo "Start the service" && \
sudo systemctl start glances.service

echo "---------------------"
tools="lm-sensors,hddtemp,inxi"
echo "Install additional monitoring tools: ${tools}"
sudo apt-get -y install $(echo ${tools} | sed 's/,/ /g')
sudo sensors-detect --auto

echo "---------------------"
echo "Check sensors"
sensors

echo "---------------------"
echo "Check inxi tool"
inxi -F

echo "---------------------"
echo "Default glaces address http://localhost:61208"
echo "To check api status: wget -O- http://localhost:61208/api/2/all"
echo ""
echo "--[End: $(basename "${0}")  ]-----------------"
