#!/bin/bash
set -eu
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


curl -L https://www.iterm2.com/utilities/imgcat > ~/.local/bin/imgcat
chmod +x ~/.local/bin/imgcat

brew install bash bash-completion
# glow              - see MarkDown files in terminal
# bat               - a 'cat' tool with syntax highlight
# lnav              - ncurses-based log file viewer
# coreutils         - is include md5sha1sum
# inetutils         - is include telnet
brew install coreutils moreutils inetutils screen tree htop mc watch
brew install gettext wget unzip p7zip pv
brew install ncdu
brew install jq yq bat glow lnav
brew install git tig
brew install shellcheck figlet macos-trash
brew install inxi neofetch

# --------------------------------------------------------------------------------
brew install awscli
brew install httping
brew install lynx elinks openssl speedtest-cli 
brew install ghostscript imagemagick
brew install xquartz
brew install qview paintbrush
# Calendar in the dock: https://www.mowglii.com/itsycal/
brew install itsycal
# Multi TZ clock in the Dock: https://abhishekbanthia.com/clocker
brew install clocker
# brew install free-ruler
#brew install mpg123
brew install ffmpeg mpv libcaca yt-dlp
brew install dmidecode kid3
brew install vlc
# brew install skype
# brew install zoom
# brew install google-chrome google-backup-and-sync
brew install iterm2 kid3 balenaetcher keepassxc
# brew install handbrake sigil
brew install microsoft-remote-desktop vnc-viewer

pip3 install --user --break-system-packages requests python-dotenv
pip3 install --user --break-system-packages visidata

# --------------------------------------------------------------------------------
# brew install xscreensaver

# brew install cmatrix

# https://github.com/pipeseroni/pipes.sh
# brew install pipes-sh

# https://gitlab.com/jallbrit/cbonsai
# brew install cbonsai

# https://github.com/brunobraga/termsaver
# pip3 install --user --break-system-packages termsaver
