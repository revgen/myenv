#!/bin/sh
# Documentation
# https://websiteforstudents.com/setup-pure-ftpd-ubuntu-17-04-17-10/
# source for docker: https://github.com/stilliard/docker-pure-ftpd/issues/1

set -o nounset
set -o errexit

echo "Install Pure FTPD"
sudo apt install pure-ftpd

echo "Enable pure-ftpd service"
sudo systemctl stop pure-ftpd.service
sudo systemctl start pure-ftpd.service
sudo systemctl enable pure-ftpd.service

echo "Create default settings"

# Daemonize = Runs Pure-FTPd as daemon
sudo su -c "echo yes > /etc/pure-ftpd/conf/Daemonize"
# NoAnonymous = disable Anonymous logins
# sudo su -c "echo no > /etc/pure-ftpd/conf/NoAnonymous"
# ChrootEveryone = Keep everyone in their home directory
sudo su -c "echo yes > /etc/pure-ftpd/conf/ChrootEveryone"
# IPV4Only = Only allow IPv4 to connect
sudo su -c "echo yes > /etc/pure-ftpd/conf/IPV4Only"
# ProhibitDotFilesWrite = Don’t not edit dot files
sudo su -c "echo no > /etc/pure-ftpd/conf/ProhibitDotFilesWrite"
sudo su -c "echo yes > /etc/pure-ftpd/conf/ProhibitDotFilesRead"
sudo su -c "echo 1000 > /etc/pure-ftpd/conf/MinUID"

sudo su -c "echo 133 022 > /etc/pure-ftpd/conf/Umask"
sudo su -c "echo no > /etc/pure-ftpd/conf/DisplayDotFiles"
sudo su -c "echo no > /etc/pure-ftpd/conf/NoRename"
sudo su -c "echo no > /etc/pure-ftpd/conf/AnonymousOnly"
sudo su -c "echo yes > /etc/pure-ftpd/conf/AnonymousCanCreateDirs"
sudo su -c "echo no > /etc/pure-ftpd/conf/AnonymousCantUpload"


sudo su -c "echo 10 > /etc/pure-ftpd/conf/MaxClientsNumber"
sudo su -c "echo 5 > /etc/pure-ftpd/conf/MaxClientsPerIP"

sudo su -c "echo no > /etc/pure-ftpd/conf/VerboseLog"
sudo su -c "echo ftp > /etc/pure-ftpd/conf/SyslogFacility"
sudo su -c "echo yes > /etc/pure-ftpd/conf/DontResolve"

sudo su -c "echo no > /etc/pure-ftpd/conf/PAMAuthentication"
sudo su -c "echo no > /etc/pure-ftpd/conf/UnixAuthentication"
sudo su -c "echo /etc/pure-ftpd/pureftpd.pdb > /etc/pure-ftpd/conf/PureDB"
sudo ln -s /etc/pure-ftpd/conf/PureDB /etc/pure-ftpd/auth/50pure


echo "Create FALSE shell"
grep /bin/false /etc/shells || echo "/bin/false" | sudo tee -a /etc/shells

echo "Create ftp user"
sudo useradd -g users -m -s -d /home/shared /bin/false ftp
# sudo passwd ftp
sudo rm /home/shared/.bash* /home/shared/.profile

echo "Reset permission for the /home/shared directory"
sudo chown nobody:users -R /home/shared
sudo chmod 0775 -R /home/shared

echo "Create virtual ftp user"
sudo pure-pw useradd user -u ftp -d /home/shared
sudo pure-pw mkdb

echo "Create default ftp directories: public, upload"
sudo mkdir -p /home/shared/{public,upload}
sudo chmod 0555 /home/ftp/public
sudo chmod 0777 /home/ftp/upload


echo "Restart pure-ftp server"
sudo systemctl restart pure-ftpd
# sudo pure-ftpd-control restart

echo "To see an activity on the ftp server use a command:"
echo "sudo pure-ftpwho"
sudo pure-ftpwho