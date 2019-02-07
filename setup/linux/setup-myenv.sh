#!/bin/sh
set -o nounset
set -o errexit
export MYENVHOME=${MYENVHOME:-"${HOME}/.local/var/myenv"}
. ${MYENVHOME}/home/.config/user.env
[ "${OSTYPE}" != "linux" ] && echo "ERROR: Incorrect os type '${OSTYPE}'" && exit 1

${MYENVHOME}/home/install-bin.sh
${MYENVHOME}/home/install-settings.sh
${MYENVHOME}/home/install-resources.sh

echo "==[ Install OS specific settings: start ]========================================="
ln-safe "${MYENVHOME}/.vscode/settings.json" "$HOME/.config/Code/User/settings.json"
echo "==[ Install OS specific settings: end   ]========================================="
