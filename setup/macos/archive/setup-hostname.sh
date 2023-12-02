#!/bin/sh
set -e
echo "The script is allow you to change current hostname (as done via System Preferences → Sharing)"
HOSTNAME="${1:-"${HOSTNAME:-$(scutil --get HostName)}"}"
read -ep "Input new hostname (default: ${HOSTNAME}): " NEW_HOSTNAME
HOSTNAME=${NEW_HOSTNAME:-"${HOSTNAME}"}
echo "Setting computer name to '${HOSTNAME}'..."
sudo scutil --set ComputerName "${HOSTNAME}"
sudo scutil --set HostName "${HOSTNAME}"
sudo scutil --set LocalHostName "${HOSTNAME}"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "${HOSTNAME}"
echo "Done"
echo "A new computer name is '$(scutil --get HostName)'"

