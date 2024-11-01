#!/bin/sh
echo "--[Begin: $(basename "${0}")]-----------------"

sudo apt install -y docker.io
curl -SL https://github.com/docker/compose/releases/download/v2.30.1/docker-compose-linux-x86_64 -o docker-compose
chmod +x docker-compose
sudo mv -vf docker-compose /usr/local/bin/docker-compose

# The following commands will start Docker and ensure that starts after the reboot
sudo systemctl start docker
sudo systemctl enable docker
echo ""
echo "Add current user to the docker group, command:"
echo "sudo usermod -aG docker $USER

echo "--[End: $(basename "${0}")  ]-----------------"
