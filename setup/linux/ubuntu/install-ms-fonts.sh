#!/bin/bash
echo "--[Begin: $(basename "${0}")]-----------------"
sudo apt install ttf-mscorefonts-installer

echo "Update font cache..."
sudo fc-cache -f -v

echo "--[End: $(basename "${0}")  ]-----------------"
