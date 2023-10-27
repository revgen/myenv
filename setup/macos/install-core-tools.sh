#!/bin/bash
title() {
    echo "======================================================================"
    echo $@
    echo "----------------------------------------------------------------------"
}

title "Install pip for the system $(python --version)"
if [ -z "$(which pip)" ]; then
    sudo easy_install pip
else
    echo "Pip already installed in the system: $(which pip)"
fi

mkdir -p ~/.local/bin 2>/dev/null

echo ""
title "Install common applications using Brew"
[ -z "$(which brew)" ] && echo "Error: install brew first." && exit 1

wget -O ~/.local/bin/imgcat https://www.iterm2.com/utilities/imgcat
chmod +x ~/.local/bin/imgcat

# brew_install mas
brew install bash bash-completion
brew install coreutils moreutil inetutils screen tree htop watch gettext wget jq unrar unzip p7zip lnav md5sha1sum ncdu pv figlet telnet
# glow              - see MarkDown files in terminal
# bat               - a 'cat' tool with syntax highlight
brew install bat glow neofetch trash-cli httping
brew install cmatrix
# brew install xscreensaver
brew install lynx elinks openssl speedtest-cli youtube-dl
brew install ghostscript imagemagick
brew install xquartz
brew install git tig vim python3
# brew_install djview4
brew install qview itsycal paintbrush free-ruler
brew install mpg123 ffmpeg mpv libcaca
brew install dmidecode
brew install vlc
brew install skype zoom
brew install google-chrome google-backup-and-sync itsycal
brew install iterm2 vnc-viewer kid3 balenaetcher handbrake sigil
brew install microsoft-remote-desktop

echo ""
read -p "Do you want to install additional Development Applications (iTerm2, Docker, VirtualBox and etc) (y/N)? " opt
echo ""
if [ "${opt}" == "Y" ] || [ "${opt}" == "y" ]; then
    brew install keepassxc
    brew install iterm2 vnc-viewer kid3 balenaetcher
    # brew install handbrake sigil
    brew install awscli
    brew install httping
    brew install node@20
    brew install java
    # brew_install wine xquartz winetricks
    # brew install virtualbox virtualbox-extension-pack
    brew install cask sourcetree
    brew install microsoft-remote-desktop
    brew install shellcheck

    # mas_install 467939042 "Growl"
    # mas_install 992362138 "iFinance 4"
fi
