#!/bin/sh
test -e /usr/sbin/sshd || sudo apt-get install openssh-server
sudo apt -y install screen mc htop git vim p7zip-full jq curl wget elinks lynx dialog tree ncdu figlet
sudo apt -y install imagemagick
sudo apt -y install net-tools
sudo apt install msmtp
echo "Done"

