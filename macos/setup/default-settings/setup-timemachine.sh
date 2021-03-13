#!/bin/sh

tm_default_settings() {
    echo "########################################################################"
    echo "# TimeMachine detault settings                                         #"
    echo "########################################################################"
    echo "* Disable Time Machine prompts for the new disks"
    defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

    echo "* Disable local Time Machine snapshots"
    sudo tmutil disablelocal 2>/dev/null
    if [ "$(defaults read /Library/Preferences/com.apple.TimeMachine MobileBackups)" == "0" ]; then
        echo "  - Local Backups disabled"
    fi
}
tm_exclude() {
    path=$1
    if [ -n "${path}" ]; then
        echo "* Excluding path from the TimeMachine: ${path}"
        if [ -e "${path}" ]; then
            sudo tmutil addexclusion -p "${path}"
            sudo tmutil isexcluded "${path}" || echo "  - Error: the ${path} not added"
        else
            echo "  - Error: path '${path}' not exists"
        fi
    fi
}

tm_exclude_all() {
    echo "########################################################################"
    echo "# TimeMachine add exclude paths                                        #"
    echo "########################################################################"
    tm_exclude "${HOME}/.docker"
    tm_exclude "${HOME}/Library/Containers/com.docker.docker"
    tm_exclude "${HOME}/VirtualBox VMs"

    tm_exclude "${HOME}/Library/Caches"

    tm_exclude "${HOME}/Applications/Games"
    tm_exclude "${HOME}/Downloads"
    tm_exclude "${HOME}/Music"
    tm_exclude "${HOME}/Movies"

    tm_exclude "$(ls -d ${HOME}/Documents/OneDrive* 2>/dev/null | head -n 1)"
    tm_exclude "/Users/shared"
    tm_exclude "/var/dump-data"
    tm_exclude "/var/tmp"
}

calculate_backup_size() {
    location=$(tmutil machinedirectory)
    echo "Current TimeMachine backup location: ${location}"
    tmutil calculatedrift "${location}"
}

tm_default_settings
tm_exclude_all
