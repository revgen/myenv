#!/bin/sh
set -o nounset
set -o errexit
export MYENVHOME=${MYENVHOME:-"${HOME}/.local/src/myenv"}
. ${MYENVHOME}/home/.config/user.env
ostype=$(uname -s | tr '[:upper:]' '[:lower:]' | sed 's/darwin/macos/g')
[ "${ostype}" != "macos" ] && echo "ERROR: Incorrect os type '${OSTYPE}'" && exit 1

${MYENVHOME}/home/install-bin.sh
${MYENVHOME}/home/install-settings.sh
${MYENVHOME}/home/install-resources.sh

echo "==[ Install OS specific settings: start ]========================================="
mkdir -p "${USERBIN}" 2>/dev/null

ln-safe "${MYENVHOME}/.vscode/settings.json" "${HOME}/Library/Application Support/Code/User/settings.json"

wget -O "${USERBIN}/imgcat" "https://www.iterm2.com/utilities/imgcat"
chmod +x ${USERBIN}/imgcat

echo "==[ Install OS specific settings: end   ]========================================="

