#!/usr/bin/env bash

echo "Core toools"
brew install moreutil


echo "Instal core X Window System tools"
brew install xquartz



echo "Install mplayer,mpv,ffmpeg"
brew install mplayer mpv libcaca


mkdir -p ~/.local/bin 2>/dev/null
wget -O ~/.local/bin/imgcat https://www.iterm2.com/utilities/imgcat
chmod +x ~/.local/bin/imgcat


#!/bin/bash
title() {
    echo "======================================================================"
    echo $@
    echo "----------------------------------------------------------------------"
}
mas_install() {
    title "[MAS] Install: [ID=${1}] ${2}"
    mas install ${1}
}
brew_install() {
    title "[BREW] Install: $@"
    if [ "${1}" == "cask" ]; then
        shift
        brew cask install $@
    else
        brew install $@
    fi
}
install_mplayer() {
    title "Install mplayer with OSD on MacOS"
    brew remove mplayer 2>&1 >/dev/null
    brew install https://raw.githubusercontent.com/Homebrew/legacy-homebrew/0f3ba89b0d2609b0464a60f60e320b5f3f2a714c/Library/Formula/mplayer.rb
    brew pin mplayer
}
title "Install pip for the system $(python --version)"
if [ -z "$(which pip)" ]; then
    sudo easy_install pip
else
    echo "Pip already installed in the system: $(which pip)"
fi
echo ""
title "Install common applications using Brew"
[ -z "$(which brew)" ] && echo "Error: install brew first." && exit 1

brew_install mas
brew_install bash bash-completion
brew_install coreutils screen tree htop watch gettext wget jq unrar unzip p7zip lnav md5sha1sum ncdu pv figlet telnet
brew_install cmatrix xscreensaver
pip install --user termsaver
brew_install lynx elinks openssl speedtest-cli youtube-dl
brew_install ghostscript imagemagick
brew_install git tig vim python3
brew_install djview4
brew_install mpg123 ffmpeg
install_mplayer
brew_install dmidecode
brew_install cask vlc
brew_install cask skype
brew_install cask google-chrome google-backup-and-sync free-ruler paintbrush itsycal

mas_install 425424353 "The Unarchiver"

echo ""
read -p "Do you want to install additional Development Applications (iTerm2, Docker, VirtualBox and etc) (y/N)? " opt
echo ""
if [ "${opt}" == "Y" ] || [ "${opt}" == "y" ]; then
    brew_install cask macvim keepassxc
    brew_install cask iterm2 vnc-viewer kid3 balenaetcher handbrake sigil
    brew_install docker
    brew_install awscli
    brew_install httping
    brew_install node java
    brew_install wine xquartz winetricks
    brew_install cask virtualbox virtualbox-extension-pack
    brew_install cask sourcetree

    mas_install 1295203466 "Microsoft Remote Desktop (10.x)"
    mas_install 467939042 "Growl"
    mas_install 992362138 "iFinance 4"
fi
