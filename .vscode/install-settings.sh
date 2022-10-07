#!/bin/sh

if [ "$(uname -s || true)" == "Darwin" ]; then
  target="$HOME/Library/Application Support/Code/User/settings.json"
  if ! which code >/dev/null && [ ! -d "/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code" ]; then
    echo "Error: VS Code not found"
    exit 1
  fi
else
  if [ "$(uname -s || true)" == "Linux" ]; then
    target=$HOME/.config/Code/User/settings.json
  fi
  if ! which code >/dev/null; then
    echo "Error: VS Code not found"
    exit 1
  fi
fi

echo "The script is copy VSCode settings.json file into your home directory"
cd "$(dirname "${0}")"
echo "- Source: ${PWD}/settings.json"
echo "- Target: ${target}"

if [ -f "${target}" ]; then
  echo "The file ${target} exists."
  read -r -p "Do you want to overwrite it (y/N)? " opt
  if [ "${opt:-"n"}" == "y" ] || [ "${opt}" == "Y" ]; then
    mv -v "${target}" "${target}.$(date +"%Y%m%d%H%M%S")"
    cp -v "${PWD}/settings.json" "${target}" || exit 1
  else
    echo "Skip"
  fi
else
  cp -v "${PWD}/settings.json" "${target}" || exit 1
fi

addons="
# Python specific
ms-python.python
ms-python.vscode-pylance
ms-python.isort

# Java
redhat.java
vscjava.vscode-java-debug

# C/C++ and .Net C#
ms-dotnettools.csharp
ms-vscode.cpptools-themes

# GoLang
golang.Go

# Git
eamodio.gitlens
donjayamanne.githistory

# Nodejs and Java Script
waderyan.nodejs-extension-pack
ms-vscode.vscode-typescript-next

# File format
andyyaldoo.vscode-json
redhat.vscode-xml
redhat.vscode-yaml
DavidAnson.vscode-markdownlint
tomoki1207.pdf
janisdd.vscode-edit-csv
hediet.vscode-drawio
mikestead.dotenv
ms-vscode.hexeditor

# Image preview
kisstkondoros.vscode-gutter-preview

# Docker and cloud
ms-azuretools.vscode-docker
ms-vscode-remote.remote-containers
ms-vscode-remote.remote-ssh
ms-vscode-remote.remote-ssh-edit
ms-vscode.remote-explorer

gitpod.gitpod-desktop

# Indent and other useful addons for coding
ephoton.indent-switcher
oderwat.indent-rainbow
formulahendry.auto-rename-tag
"
echo ""
echo "Useful addons:"
echo "${addons}" | grep -v '^$'
read -p "Do you want to install these addons (y/N)? " opt
if [ "${opt:-"n"}" == "y" ] || [ "${opt}" == "Y" ]; then
    echo "${addons}" | grep -v '^$' | grep -v "^#" | while read -r addon; do
        echo "Install ${addon}"
        code --install-extension "${addon}"
    done
fi
