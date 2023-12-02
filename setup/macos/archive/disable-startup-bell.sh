#!/usr/bin/env bash
echo "Disable the sound effects on boot (need root to setup)"
read -n 1 -p "Are you sure (y/N)? " opt
if [ "${opt}" == "y" ]; then
    echo ""
    sudo nvram SystemAudioVolume=" "
    echo "Done"
else
    echo "Skipped"
fi

