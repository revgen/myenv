#!/bin/bash
echo "--[Begin: $(basename "${0}")]-----------------"
echo "Install dependencies..."
sudo python3 -m pip install uvicorn bottle fastapi ujson --break-system-packages || exit 1

echo "Install glaces to the system"
sudo python3 -m pip install glances --break-system-packages || exit 1

/usr/local/bin/glances --version
echo "Create glances.service file"
echo -e "[Unit]
Description=Glances
After=network.target

[Service]
ExecStart=/usr/local/bin/glances -w
Restart=on-abort

[Install]
WantedBy=multi-user.target
" > /tmp/glances.service
echo "Put it to the system -> /etc/systemd/system/glances.service"
sudo mv /tmp/glances.service /etc/systemd/system/glances.service || exit 1
echo "Enable unit for automatic start while booting..."
sudo systemctl enable glances.service
echo "Start the service"
sudo systemctl start glances.service

echo "Installation is done."
systemctl status glances

api_ver=$(/usr/local/bin/glances --version | grep "API" | cut -d":" -f2 | sed 's/[\t ]*//g')
echo "---------------------"
echo "Default glaces address http://localhost:61208"
echo "Glances has API version = ${api_version}"
echo "To check api status: wget -O- http://localhost:61208/api/${api_ver}/status"
wget -qO- http://localhost:61208/api/${api_ver}/status
echo ""
echo "--[End: $(basename "${0}")  ]-----------------"

