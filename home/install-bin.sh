#!/bin/sh
set -o nounset
set -o errexit
export MYENVHOME=${MYENVHOME:-"${HOME}/.local/var/myenv"}
. ${MYENVHOME}/home/.config/user.env
export PATH=${MYENVHOME}/home/bin:${PATH}
ostype=$(uname -s | tr '[:upper:]' '[:lower:]' | sed 's/darwin/macos/g')

make_links_from_all() {
    orig_dir=${1}
    link_dir=${2}
    cd ${orig_dir}
    for f in $(find . -maxdepth 1 -type f; find "./" -maxdepth 1 -type l); do
        if [ -e "$f" ] && [ -x "$f" ]; then
            filename=$(basename "${f}")
            syslink=$(fullpath "${link_dir}/$filename")
            target=$(fullpath "${orig_dir}/$f")
            ln-safe "${target}" "${syslink}"
        fi
    done
    cd - > /dev/null
}

SCRIPT_DIR=$(fullpath "$(dirname "${0}")")
echo "==[ Install main tools: start ]========================================="
echo "MYENVHOME = ${MYENVHOME}"
cd ${SCRIPT_DIR}/../home/bin
echo "Install tools from the myenv/home/bin directory"
echo "Copy ${PWD} -> ${USERBIN}"
mkdir -p "${USERBIN}" 2>/dev/null
make_links_from_all "${PWD}" "${USERBIN}"
make_links_from_all "${PWD}/${ostype}" "${USERBIN}"
echo "==[ Install main tools: end   ]========================================="
