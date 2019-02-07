#!/usr/bin/env bash
echo "--[Begin: $(basename "${0}")]-----------------"
lsb_release -i | grep "Ubuntu" >/dev/null
if [ $? -ne 0 ]; then
    echo "Error: use Ubuntu system only"
    exit 1
fi
echo "================================================================"
echo "Virtualbox On Ubuntu 18.04 can be easily installed from Ubuntu's multiverse repository"
sudo apt install virtualbox virtualbox-ext-pack

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
