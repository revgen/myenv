#!/bin/bash
set -o nounset
set -o errexit
export MYENVHOME=${MYENVHOME:-"${HOME}/.local/var/myenv"}
. ${MYENVHOME}/home/.config/user.env

download_url() {
    [ -f "${2}" ] && rm "${2}"
    if [ -n "$(which curl)" ]; then curl -Lso ${1} "${2}";
    else wget -qO ${1} "${2}"; fi
}

download_and_install() {
    echo "Downloading ${2} -> ${1}..."
    download_url "${1}" "${2}" && \
        chmod +x "${1}" && \
        echo " - Download success: $(du -s "${1}")"
}

cd $(dirname "${0}")
SRC=${PWD}
DEST=${HOME}/.local/bin
read -p "Do you want install additional tools into you home environment (y/N)? " opt
if [ "${opt:-"N"}" == "Y" ] || [ "${opt}" == "y" ]; then
    ln-safe "${SRC}/crypt/crypt" "${DEST}/crypt"
    ln-safe "${SRC}/pdfutil/pdfutil" "${DEST}/pdfutil"
    ln-safe "${SRC}/screensaver/screensaver" "${DEST}/screensaver"
    ln-safe "${SRC}/google/goomus" "${DEST}/goomus"
    ln-safe "${SRC}/firefox/firefox" "${DEST}/firefox"
    for name in $(ls "${SRC}/dev/"); do
        ln-safe "${SRC}/dev/${name}" "${DEST}/${name}"
    done
    download_and_install "${DEST}/dockdb" "https://raw.githubusercontent.com/revgen/docker-repository/master/docker-database/bin/dockdb"
    download_and_install "${DEST}/transmission" "https://raw.githubusercontent.com/revgen/docker-repository/master/docker-transmission/bin/transmission"
else
    echo "Skip"
fi
