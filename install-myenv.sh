#!/usr/bin/env bash
#=============================================================================
## Install myenv to the home environment
#=============================================================================
[ "${DEBUG}" == "true" ] && set -x
set -eo pipefail
set -o nounset
shopt -s dotglob
hr2() { echo -e "\033[0;32m======================================================================\033[0m"; }
hr()  { echo -e "\033[0;34m- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -\033[0m"; }
step() { echo ""; text="$(printf '%-79s' "• $@")"; echo -e "\033[4;94m${text}\033[0m"; }
alert() { echo -e "\033[1;31m$@\033[0m"; }
prompt() { read -p "${1} " opt; [ "${opt}" != "${2:-"y"}" ] && echo "Skipped" && return 1; echo ""; }
cpx() { mkdir -p "$(dirname "${2}")" 2>/dev/null; rsync -a -v "${1}" "${2}" || exit 1; }

case "$OSTYPE" in
  linux*)
    if grep "Microsoft\|WSL" /proc/sys/kernel/osrelease > /dev/null; then export OSNAME=wsl;
    else export OSNAME=linux; fi
    ;;
  solaris*) export OSNAME=solaris ;;
  darwin*)  export OSNAME=macos ;; 
  bsd*)     export OSNAME=bsd ;;
  msys*)    export OSNAME=windows ;;
  cygwin*)  export OSNAME=windows ;;
  *)        export OSNAME=unknown ;;
esac

repo_url=https://github.com/revgen/myenv/archive/master.tar.gz
cd "$(dirname "$(echo "${0}" | sed 's/^-bash$/~\/.local/g')")"
export HOME=${HOME}
export BIN="${HOME}/.local/bin"
export MYENVHOME="${HOME}/.local/var/src/myenv"
export MYENVSRC=${MYENVSRC:-"${HOME}/.local/var/tmp/myenv"}
bash_updated=0
# -----------------------------------------------------------------------------
prompt_to_install() {
    clear
    echo "The script is helping you to install myenv into your system"
    hr2
    echo -e "\033[0;32mSYSTEM   :\033[0;33m ${OSNAME} (${OSTYPE})\033[0m"
    echo -e "\033[0;32mHOME     :\033[0;33m ${HOME}\033[0m"
    echo -e "\033[0;32mBIN      :\033[0;33m ${BIN}\033[0m"
    echo -e "\033[0;32mMYENVHOME:\033[0;33m ${MYENVHOME}\033[0m"
    echo -e "\033[0;32mMYENVSRC :\033[0;33m ${MYENVSRC}\033[0m"
    echo -e "\033[0;32mPWD      :\033[0;33m ${PWD}\033[0m"
    hr2
    if [ "${MYENVHOME}" == "${PWD}" ]; then
        echo "You are running the installation script from the MYENVHOME directory"
        prompt "Do you want to setup myenv tools and settings into your home ${HOME} (y/N)? " || exit 1
        return 1
    fi
    echo "The script will download source code for your system into the MYENVHOME."
    prompt "Continue installation (y/N)?" || exit 1
}

# -----------------------------------------------------------------------------
download_myenv_distr() {
    echo "Prepeare a temp directory for the source: ${MYENVSRC}"
    if [ -d "${MYENVSRC}" ]; then
        # prompt "The directory exists. Are you agree to clean it first (y/N)?" || exit 1
        echo "The directory exists and it will be deleted"
        rm -rf "${MYENVSRC}"
    fi
    mkdir -p "${MYENVSRC}"
    target=myenv.tar.gz
    step "Download ${repo_url} -> ${target}"
    rm -rf "${target}" 2>/dev/null
    if which wget >/dev/null; then
        # Fix problem with the wget tool o WSL: could not open HSTS store
        touch "${HOME}/.wget-hsts"; chmod 644 "${HOME}/.wget-hsts"
        wget -O ${target} https://github.com/revgen/myenv/archive/master.tar.gz || exit 1
    else
        curl -L https://github.com/revgen/myenv/archive/master.tar.gz > ${target} || exit 1
    fi
    echo "Extract files into the ${MYENVSRC}"
    tar -xz -C "${MYENVSRC}" -f "${target}" || exit 1
    cd "${MYENVSRC}"
    mv myenv-master/* ./ || exit 1
    rm -r myenv-master || exit 1
    cd - >/dev/null
    rm -rf "${target}"
    echo "The source code downloaded into the ${MYENVSRC} directory"
    ls -ahl "${MYENVSRC}"
}

# -----------------------------------------------------------------------------
copy_to_local_home() {
     step "Copy all files into the MYENVHOME directory: ${MYENVHOME}"
    if [ -d "${MYENVHOME}" ]; then
        prompt "The directory exists. Do you want to clean it first (y/N)?" || exit 1
        rm -rf "${MYENVHOME}"
    fi
    [ -d "${MYENVSRC}/home/" ] && cpx "${MYENVSRC}/home/" "${MYENVHOME}/home/"
    [ -d "${MYENVSRC}/${OSNAME}/home/" ] && cpx "${MYENVSRC}/${OSNAME}/home/" "${MYENVHOME}/home/"
    [ -d "${MYENVSRC}/${OSNAME}/setup/" ] && cpx "${MYENVSRC}/${OSNAME}/setup/" "${MYENVHOME}/setup/"
    cp -vf "${MYENVSRC}/install-myenv.sh" "${MYENVHOME}/"
    chmod +x "${MYENVHOME}/install-myenv.sh"

    step "Copy extra files into the MYENVHOME directory: ${MYENVHOME}"
    prompt "Do you want to install extra scripts and tools (y/N)?" && \
    (
        if [ -d "${MYENVSRC}/extra/" ]; then
            cpx "${MYENVSRC}/extra/" "${MYENVHOME}/home/"
        fi
        if [ -d "${MYENVSRC}/${OSNAME}/extra/" ]; then
            cpx "${MYENVSRC}/${OSNAME}/extra/" "${MYENVHOME}/home/"
        fi
    )
    echo "Clean temp directory: ${MYENVSRC}"
    rm -rf "${MYENVSRC}"
}

# -----------------------------------------------------------------------------
update_bashrc() {
    bashrc=${HOME}/.bashrc
    bashprofile=${HOME}/.bash_profile
    step "Update ${bashrc} file"
    if [ "${OSNAME}" == "macos" ] && [ ! -e "${bashprofile}" ]; then
        echo "Create ${bashprofile} first"
        echo '[ -r "${HOME}/.bashrc" ] && . "${HOME}/.bashrc"' > "${bashprofile}"
        ls -ahl "${bashprofile}"
    fi
    existed_rows=$(grep "export MYENVHOME" "${bashrc}" 2>/dev/null || true)
    if [ -n "${existed_rows}" ]; then
        alert "Worning: found MYENV settings in the ${bashrc} file."
        echo -e "\033[0;90m${existed_rows}\033[0m";
        alert "The file ${bashrc} not updated."
        # prompt "Do you want to continue installation (y/N)?" || exit 1
    else
echo "Add MYENVHOME to the user home system environment"
        echo '
# --[ Load MYENV configuration ]--------------------------
export OSNAME="'"${OSNAME}"'"
export MYENVHOME="'"${MYENVHOME}"'"
if [ -r "${MYENVHOME}/home/.config/bashrc" ]; then
    . "${MYENVHOME}/home/.config/bashrc"
else
    echo "\033[1;31mError in ~/.bashrc - \"${MYENVHOME}/home/.config/bashrc\" not found.\033[0m"
fi
# --[ Load MYENV configuration:end ]----------------------
' >> "${bashrc}"
        bash_updated=1
        existed_rows=$(grep "export MYENVHOME" "${bashrc}" 2>/dev/null)
        echo -e "\033[0;90m${existed_rows}\033[0m";
    fi
}

# -----------------------------------------------------------------------------
setup_myenv_in_user_home() {
    step "Setup myenv into your home: ${HOME}"
    echo "Symlink all files from the ${MYENVHOME}/home, except .config/*."
    cd ${MYENVHOME}/home
    find . -type f -o -type l | grep -v ".config/" | sed 's/^\.\///g' | while read f; do
        target=${HOME}/${f}
        # echo "${target} -> ${MYENVHOME}/home/${f}"
        mkdir -p "$(dirname "${target}")" 2>/dev/null
        ln -vsf "${MYENVHOME}/home/${f}" "${target}"
    done
    cd - >/dev/null
}

# -----------------------------------------------------------------------------

prompt_to_install && \
download_myenv_distr && \
copy_to_local_home

setup_myenv_in_user_home
update_bashrc

step "Done"
if [ ${bash_updated} -eq 1 ]; then
    echo "Restart your terminal session and use 'me --help' command."
fi
${MYENVHOME}/home/.local/bin/myenv --version
${MYENVHOME}/home/.local/bin/myenv --home
echo ""

