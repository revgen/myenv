#!/bin/bash
export MYENVHOME=${MYENVHOME:-"${HOME}/.local/src/myenv"}
. ${MYENVHOME}/home/.config/user.env
export PATH=${MYENVHOME}/home/bin:${PATH}
SCRIPT_DIR=${PWD}

copy_service() {
    [ -z "${1}" ] && echo "Error: service name is required" && return 1
    echo ""
    if [ -e "${HOME}/${1}" ]; then
        echo "'${HOME}/${1}' exists."
        read -p "Do you want to remove it (y/N)? " opt
        if [ "${opt}" != "Y" ] && [ "${opt}" != "y" ]; then
            echo "Skip."
            return 0
        else
            rm -r "${HOME}/${1}"
        fi
    fi
    if [ -e "${HOME}/${1}" ]; then
        echo "Error: '${HOME}/${1}' exists - skip'"
    else
        ln-safe --copy --overwrite "${SCRIPT_DIR}/${1}" "${HOME}/${1}"
    fi
}

echo "########################################################################"
cd $(dirname "${0}")
copy_service "Library/Services/Start iTerm.workflow"
copy_service "Library/Services/Start Screen Saver.workflow"
echo ""
cd - >/dev/null
echo "########################################################################"

