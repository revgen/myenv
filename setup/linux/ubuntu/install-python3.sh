#!/bin/sh
if ! which python3 >/dev/null; then
    sudo apt -y install python3
fi
if ! which pip3 >/dev/null; then
    sudo apt -y install python3-pip
fi
[ -z "$(which python)" ] && echo "Create symlink: python -> python3" && sudo ln -fs $(which python3) /usr/bin/python
[ -z "$(which pip)" ] && echo "Create symlink: pip -> pip3" && sudo ln -fs $(which pip3) /usr/bin/pip
echo "Done"

