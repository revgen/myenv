#!/bin/sh
sudo apt-get -y install python3 python3-pip
[ -z "$(which python)" ] && echo "Create symlink: python -> python3" && sudo ln -fs $(which python3) /usr/bin/python
[ -z "$(which pip)" ] && echo "Create symlink: pip -> pip3" && sudo ln -fs $(which pip3) /usr/bin/pip
echo "Done"

