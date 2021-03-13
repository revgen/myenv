#!/usr/bin/env bash
read -n 1 -p "Do you want to use Bash as a default shell (y/N)? " opt
if [ "${opt}" == "y" ]; then
    echo ""
    chsh -s /bin/bash
    echo "Done"
else
    echo "Skipped"
fi

