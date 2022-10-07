#!/bin/sh
sudo apt -y install software-properties-common
################################################################################
# If you want to install python3.9 please read a link: https://stackoverflow.com/a/64353748
################################################################################

if ! which python3 >/dev/null; then
    sudo apt -y install python3
fi

if ! which pip3 >/dev/null; then
    sudo apt -y install python3-pip
fi
[ -z "$(which python)" ] && echo "Create symlink: python -> python3" && sudo ln -fs $(which python3) /usr/bin/python
[ -z "$(which pip)" ] && echo "Create symlink: pip -> pip3" && sudo ln -fs $(which pip3) /usr/bin/pip

pip3 install requests
pip3 install docker-compose
pip3 install python-dotenv
pip3 install pylint pylint-quotes pylint-unittest

echo "Done"

