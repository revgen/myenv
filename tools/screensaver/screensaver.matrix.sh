#!/bin/sh
if [ -z "$(which cmatrix)" ]; then
    echo "Error: Can't find cmatrix application. Please install it first."
    echo "  # apt-get installl cmatrix"
    echo "  # brew install cmatrix"
else
    cmatrix -sab -u2
fi
