#!/bin/sh
echo "--[Begin: $(basename "${0}")]-----------------"

sudo apt install docker.io
#sudo pip install docker-compose
# The following commands will start Docker and ensure that starts after the reboot
sudo systemctl start docker
sudo systemctl enable docker
echo ""
echo "Add current user to the docker group"
sudo usermod -aG docker $USER

echo "--[End: $(basename "${0}")  ]-----------------"
