#!/bin/sh
echo "============================================================"
tools="openssh-server, screen, mc, htop, git, vim, p7zip-full, jq, lynx, curl, wget, elinks, python3, python3-pip, dialog, tree"
echo "Install core linux tools: ${tools}"
sudo apt-get install $(echo ${tools} | sed 's/,/ /g')

[ -z "$(which python)" ] && echo "Create symlink: python -> python3" && sudo ln -fs $(which python3) /usr/bin/python
[ -z "$(which pip)" ] && echo "Create symlink: pip -> pip3" && sudo ln -fs $(which pip3) /usr/bin/pip

echo "Done"

