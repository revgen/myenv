#!/bin/bash
#=============================================================================
## Install myenv to the home environment
## Usage: {SCRIPT_NAME} [directory]
## Description:
##   directory - myenv home directory, you can specify it with first argument or
##               with MYENVHOME environment veriable.
##               Default: MYENVHOME = ${HOME}/.local/var/myenv
#-----------------------------------------------------------------------------
#                         WORKFLOW
# install.sh
#   |
#   +-- Check ${MYENVHOME}. Exists?
#      <yes>    <no >
#        |        |
#        |    Download myenv.package (/tmp)
#        |        |
#        |    Extract repository from the package
#        |        | 
#        +----+---+
#             |
#             +-- setup/<os>/setup-myenv.sh
#                             |
#                             +-- home/install-bin.sh
#                             +-- home/install-settings.sh
#                             +-- home/install-settings.sh
#                             +-- custom installation code related to the OS
#=============================================================================
# set -o nounset
set -o errexit
repo_url=https://github.com/revgen/myenv/archive/master.tar.gz
ostype=$(uname -s | tr '[:upper:]' '[:lower:]' | sed 's/darwin/macos/g')

#---[ Function: work with MYENVHOME ]-----------------------------------------
step() { echo "--[${1}]-------------------------------------------------"; }

is_correct_myenvdir() {
    if [ -f "${1}/home/.config/user.bashrc" ]; then return 0;
    else return 1; fi
}

download() {
    if [ -n "$(which curl)" ]; then download_app="curl -L -o";
    else download_app="wget -O"; fi

    echo "Download data from ${1} into the ${2}" \
    && ${download_app} "${2}" "${1}"
}

extract() {
    archive_dir=$(dirname "${1}")
    archive_name=$(basename "${1}")
    target=${2}
    name=$(tar tf "${1}" | head -n 1)
    (rm -rf "${target}" || true) \
    && echo "Extracting data from archive ${archive_name} in ${archive_dir}..." \
    && echo "Unpack data to the temporary directory..." \
    && cd ${archive_dir} \
    && tar xzf "${archive_name}" \
    && cd "${name}" \
    && echo "Extracted data directory ${PWD}" \
    && rm -v "${archive_dir}/${archive_name}" \
    && echo "Copy all files: ${PWD} -> ${target}" \
    && (mkdir -p "${target}" 2>/dev/null || true) \
    && cp -Rf ./ "${target}" \
    && cd .. \
    && rm -r "${name}" \
    && cd "${target}" \
    && echo "Data extracted successfully in ${PWD}:" \
    && ls -ahl ./
}

setup() {
    step "Setup"
    cd ${MYENVHOME}
    export MYENVHOME=${PWD}
    echo "Calling ${PWD}/setup/${ostype}/setup-myenv.sh"
    "${PWD}/setup/${ostype}/setup-myenv.sh" || exit 1
}

finish() {
    echo "Done"
    cd ${MYENVHOME}
    echo "MYENVHOME=${PWD}" \
    && echo "Restart terminal session first and use 'me --help' command." && exit 0
    exit 1
}

#---[ Main ]------------------------------------------------------------------
echo "Args: '${1:-"empty"}' '${2:-"empty"}' '${3:-"empty"}'"
echo "MYENVHOME = ${MYENVHOME}"
case "${1:-""}" in
    help|--help)
        sed -n '/^##/,/^$/s/^## \{0,1\}//p' "$0" | sed 's/{SCRIPT_NAME}/'"${0##*/}"'/g'
        exit 255 ;;
    *) MYENVHOME=${1:-"${MYENVHOME:-""}"} ;;
esac
[ -z "${MYENVHOME}" ] && MYENVHOME=${HOME}/.local/var/myenv
echo "MYENVHOME = ${MYENVHOME}"

echo "==[OS: ${ostype}] ========================================="
echo "Install myenv to your home environment: ${MYENVHOME}"
echo ""

source_dir=$(dirname "${0}")
# When we are call install.sh from the localrepository, we can use it as a myenv
if is_correct_myenvdir "${source_dir}"; then
    echo "You are inside the local copy of the myenv repository."
    read -p "Would you like to use it as your MYENVHOME it (y/N)? " opt
    if [ "${opt:-"N"}" == "Y" ] || [ "${opt}" == "y" ]; then
        MYENVHOME=${source_dir}
        setup && finish
    fi
fi

step "Check old installation"
# Check if myenv directory exists and update it
if [ -d "${MYENVHOME}" ]; then
    echo "The directory '${MYENVHOME}' exists."
    if ! is_correct_myenvdir "${MYENVHOME}"; then
        echo "Error: It is not a myenv directory. You should clean '${MYENVHOME}' first."
        exit 1
    fi

    echo "This is a correct myenv directory. "
    read -p "Would you like to update it (y/N)? " opt
    if [ "${opt:-"N"}" != "Y" ] && [ "${opt}" != "y" ]; then
        echo "Skip"
        exit 1
    fi
    bakname=${MYENVHOME}.$(date +"%Y%m%d-%H%M%S").tar.gz
    echo "Backup old directory: ${MYENVHOME} -> ${bakname}"
    tar czf "${bakname}" "${MYENVHOME}" \
    && rm -rf "${MYENVHOME}"
fi

step "Download"
# Download a repository archive from the git
# read -p "Would you like to download myenv distribution from the ${repo_url} (Y/n)? " opt
# if [ "${opt:-"Y"}" != "Y" ] && [ "${opt}" != "y" ]; then
#     echo "Skip"
#     exit 1
# fi
tmpdir=/tmp/myenv-master-${RANDOM}
if ! download "${repo_url}" "${tmpdir}.tar.gz"; then
    echo "Error: there is a problem to download a repository archive."
    exit 1
else
    step "Extraction"
    if ! extract "${tmpdir}.tar.gz" "${MYENVHOME}"; then
        echo "Error: there is a problem to extract data from the archive."
        exit 1
    fi
    if ! is_correct_myenvdir "${MYENVHOME}"; then
        echo "Error: there is a problem to setup myenv."
        exit 1
    fi
    setup && finish
fi


prompt() {
    opt=
    # check interactive mode or pipe mode
    # './install.sh' or 'install.sh | sh'
    case "${0##*/}" in
        sh|bash)
            opt="${2:-"y"}"
            echo "${1} < ${opt} (pipe mode)"
            ;;
        *)
            read -n 1 -p "${1}" opt
            echo ""
            ;;
    esac
    if [ "${opt}" != "Y" ] && [ "${opt}" != "y" ]; then
        return 1
    fi
    return 0
}


