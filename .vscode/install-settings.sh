#!/bin/sh

if [ "$(uname -s)" == "Darwin" ]; then
  target="$HOME/Library/Application Support/Code/User/settings.json"
else
  if [ "$(uname -s)" == "Linux" ]; then
    target=$HOME/.config/Code/User/settings.json
  fi
fi

echo "The script is copy VSCode settings.json file into your home directory"
cd "$(dirname "${0}")"
echo "Source: ${PWD}/settings.json"
echo "Target: ${target}"

if [ -f "${target}" ]; then
  echo "The file ${target} exists."
  read -r -p "Do you want to overwrite it (y/N)? " opt
  if [ "${opt:-"n"}" != "y" ] && [ "${opt}" != "Y" ]; then echo "Skip"; exit 1; fi
  mv -v "${target}" "${target}.$(date +"%Y%m%d%H%M%S")"
fi
# read -r -p "Do you want to copy (Y/n)? " opt
cp -v "${PWD}/settings.json" "${target}"
