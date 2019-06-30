#!/usr/bin/env bash
echo "--[Begin: $(basename "${0}")]-----------------"
lsb_release -i | grep "Ubuntu" >/dev/null
if [ $? -ne 0 ]; then
    echo "Error: use Ubuntu system only"
    exit 1
fi
set -e

echo "================================================================"
echo "Virtualbox 6.X"
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
sudo sh -c 'echo "deb http://download.virtualbox.org/virtualbox/debian $(lsb_release -sc) contrib" >> /etc/apt/sources.list.d/virtualbox.list'
sudo apt update
sudo apt-get install virtualbox-6.0

echo "Installing Virtual Box Extension Pack"
vbox_version=$(vboxmanage --version | cut -d"r" -f1)
echo "Version is ${vbox_version}"
[ -z "${vbox_version}" ] && echo "Error" && exit 1

wget https://download.virtualbox.org/virtualbox/${vbox_version}/Oracle_VM_VirtualBox_Extension_Pack-${vbox_version}.vbox-extpack
sudo VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-${vbox_version}.vbox-extpack


echo "Add '${USER}' user to the vboxusers group"
sudo usermod -aG vboxusers ${USER}
echo "================================================================"

printf "VirtualBox: " && VBoxManage -v && VBoxManage list extpacks
echo "Done"

# If the virtualbox module doesn’t start, run the following command to start it.
# sudo /etc/init.d/vboxdrv setup

# Base command line commands (https://www.virtualbox.org/manual/ch08.html):
#
# Start virtual machine:
#   VBoxManage startvm "Name|uuid" --type headless
# Start virtual machine with enabled VRDP:
#   VBoxHeadless --startvm <name|uuid> --vrde on
#
# Stop virtual machine:
#   VBoxManage controlvm <name|uuid> poweroff
#
# Show virtual machine information:
#   VBoxManage showvminfo <name|uuid>
#
# Show all virtual machines:
#   vboxmanage list vms
#
# Import ova:
#   vboxmanage import test.ova
# Import ova with new name:
#   vboxmanage import test.ova --vsys 0 --vmname <name>
#
echo "--[End: $(basename "${0}")  ]-----------------"
