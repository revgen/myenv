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
brew install coreutils moreutils inetutils screen tree htop mc watch
brew install gettext wget telnet unzip p7zip md5sha1sum ncdu pv
brew install jq yq bat glow lnav
brew install shellcheck tig figlet neofetch macos-trash

# --------------------------------------------------------------------------------
brew install awscli
brew install httping
brew install lynx elinks openssl speedtest-cli 
brew install ghostscript imagemagick
brew install xquartz
brew install git tig neovim
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
brew install iterm2 vnc-viewer kid3 balenaetcher handbrake sigil keepassxc
brew install microsoft-remote-desktop

pip3 install --user --break-system-packages requests python-dotenv
pip3 install --user --break-system-packages visidata

# --------------------------------------------------------------------------------
# brew install cmatrix
# brew install xscreensaver
# pip3 install --user termsaver
