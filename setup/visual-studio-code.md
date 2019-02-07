# [Visual Studio Code](https://code.visualstudio.com/)


## Installation

You can find an installation package for the most platforms [here](https://code.visualstudio.com/download).

### Install Visual Studio Code on MacOS
```bash
brew cask install visual-studio-code
```

### Install Visual Studio Code on Ubuntu
```bash
sudo apt install software-properties-common apt-transport-https wget
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
sudo apt install code
```

### Install Visual Studio Code on Windows

* [Install from the site](https://code.visualstudio.com/docs/setup/windows)
* Install from the command line using Chocolatey:
```bat
choco install vscode
```


## Extensions

[Visual Studio Code Extension Gallery](https://code.visualstudio.com/docs/editor/extension-gallery)

### Command Line Interface to work with extensions:
```
code --list-extensions
code --install-extension ms-vscode.cpptools
code --uninstall-extension ms-vscode.csharp
```

### List of my extensions
```
# A darck scheme inspired by the IntelliJ
code --install-extension alex-pex.theme-darkula

# Python language 
code --install-extension ms-python.python

# Powershell language file
code --install-extension ms-vscode.PowerShell

# Windows REG file
code --install-extension ionutvmi.reg

# TSLint for VSCode
code --install-extension eg2.tslint

# Adds syntax highlighting for Dockerfile
code --install-extension PeterJausovec.vscode-docker

# Git History
code --install-extension donjayamanne.githistory

# Git History Diff
code --install-extension huizhou.githd

# Image preview
code --install-extension kisstkondoros.vscode-gutter-preview

# Display PDF file in VSCode
code --install-extension tomoki1207.pdf

# Add commands to switch indent: "Switch indent from 2 to 4" or "Switch indent from 4 to 2"
code --install-extension ephoton.indent-switcher
# Makes indentation easier to read
code --install-extension oderwat.indent-rainbow

# Language Support for Java by RedHat
code --install-extension redhat.java
```
