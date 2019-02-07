#!/usr/bin/env bash
echo "--[Begin: $(basename "${0}")]-----------------"
lsb_release -i | grep "Ubuntu" >/dev/null
if [ $? -ne 0 ]; then
    echo "Error: use Ubuntu system only"
    exit 1
fi

echo "================================================================" && \
echo "Add VirtualBox repository and key" && \
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add - && \
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add - && \
\
sudo sh -c 'echo "deb http://download.virtualbox.org/virtualbox/debian $(lsb_release -sc) contrib" > /etc/apt/sources.list.d/virtualbox.list' && \
\
echo "Updating reposoties.." && \
sudo apt-get update && \
\
echo "Install VirtualBox" && \
sudo apt-get install virtualbox && \
echo "Check installed VirtualBox version" && \
VBoxManage -v && \
echo "Check runned virtualbox instance" && \
sudo systemctl status vboxweb.service && \
\
echo "Add user to the vboxusers group" && \
sudo usermod -aG vboxusers ${USER} && \
\
echo "================================================================" && \
echo "Install VirtualBox extenion pack" && \
export vbox_ver=$(VBoxManage -v | cut -d"_" -f1) && \
wget -O /tmp/Oracle_VM_VirtualBox_Extension_Pack-${vbox_ver}.vbox-extpack "http://download.virtualbox.org/virtualbox/${vbox_ver}/Oracle_VM_VirtualBox_Extension_Pack-${vbox_ver}.vbox-extpack" && \
sudo VBoxManage extpack install /tmp/Oracle_VM_VirtualBox_Extension_Pack-${vbox_ver}.vbox-extpack && \
echo "Show a list of all VirtualBox extensions:" && \
VBoxManage list extpacks && \
echo "================================================================" && \
echo "" && \
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
