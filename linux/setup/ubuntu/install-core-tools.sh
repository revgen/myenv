#!/bin/sh
test -e /usr/sbin/sshd || sudo apt-get install openssh-server
sudo apt -y purge vim vim-common vim-runtime 
sudo apt -y install screen mc htop git curl wget elinks lynx 
sudo apt -y install neovim p7zip-full jq tree ncdu figlet dialog
sudo apt -y install imagemagick id3v2
sudo apt -y install net-tools
sudo apt -y install dnsutils
# sudo apt -y install msmtp

# --[ exfat ] -----------------------------------------------------------------
# sudo apt install -y exfat-fuse exfat-utils
## sudo mount -t exfat /dev/sdc1 /media/exfat
# --[ ntfs  ] -----------------------------------------------------------------
# sudo apt install -y ntfs-3g
## sudo mount -t ntfs -o nls=utf8,umask=0222 /dev/sdb1 /media/windows
# --[ hfs   ] -----------------------------------------------------------------
# sudo apt install -y hfsprogs
## sudo mount -t hfsplus -o force,rw /dev/sdx# /media/mntpoint

echo "Done"

