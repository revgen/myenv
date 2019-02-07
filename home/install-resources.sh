#!/bin/sh
set -o nounset
set -o errexit
export MYENVHOME=${MYENVHOME:-"${HOME}/.local/var/myenv"}
. ${MYENVHOME}/home/.config/user.env
export PATH=${MYENVHOME}/home/bin:${PATH}

echo "==[ Install main settings: start ]========================================="
echo ">>> Add radio playlists to the home music directory"
ln-safe "${MYENVHOME}/home/music/radio" "${HOME}/Music/Radio"
echo "==[ Install main settings: end   ]========================================="
