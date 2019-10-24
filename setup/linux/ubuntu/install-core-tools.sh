#!/bin/sh
test -e /usr/sbin/sshd || sudo apt-get install openssh-server
sudo apt-get -y install screen mc htop git vim p7zip-full jq curl wget elinks lynx dialog tree ncdu
sudo apt-get install msmtp
echo "Done"

