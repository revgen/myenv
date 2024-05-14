#!/bin/bash
title() {
    echo "======================================================================"
    echo $@
    echo "----------------------------------------------------------------------"
}
mkdir -p ~/.local/bin 2>/dev/null

echo ""
title "Install common applications using Brew"
[ -z "$(which brew)" ] && echo "Error: install brew first." && exit 1

wget -O ~/.local/bin/imgcat https://www.iterm2.com/utilities/imgcat
chmod +x ~/.local/bin/imgcat

brew install bash bash-completion
# glow              - see MarkDown files in terminal
# bat               - a 'cat' tool with syntax highlight
# lnav              - ncurses-based log file viewer
brew install coreutils moreutil inetutils screen tree htop mc watch
brew install gettext wget telnet jq unzip p7zip lnav md5sha1sum ncdu pv
brew install bat glow shellcheck tig unrar figlet neofetch trash-cli
# --------------------------------------------------------------------------------
brew install httping awscli
brew install lynx elinks openssl speedtest-cli 
brew install ghostscript imagemagick
brew install xquartz
brew install git tig neovim
brew install qview itsycal paintbrush
brew install itsycal
# brew install free-ruler
brew install mpg123 ffmpeg mpv libcaca yt-dlp dmidecode kid3
# brew install vlc
# brew install skype
# brew install zoom
# brew install google-chrome google-backup-and-sync
brew install iterm2 vnc-viewer kid3 balenaetcher handbrake sigil keepassxc
brew install microsoft-remote-desktop

pip3 install --user requests python-dotenv
pip3 install visidata

# --------------------------------------------------------------------------------
brew install cmatrix
brew install xscreensaver
pip3 install --user termsaver
