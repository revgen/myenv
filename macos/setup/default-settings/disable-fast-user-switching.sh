#!/usr/bin/env bash
echo "Disable Fast User Switching (hide on the panel, near the clock)"
read -n 1 -p "Are you sure (y/N)? " opt
if [ "${opt}" == "y" ]; then
    echo ""
    sudo defaults write /Library/Preferences/.GlobalPreferences MultipleSessionEnabled -bool NO
    killall Dock
    echo "Done"
else
    echo "Skipped"
fi

