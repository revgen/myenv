# Mac OS settings, tools and applications

* [System settings](#system-settings)
* [Tools](#tools)
  * [Homebrew](#homebrew)
  * [Command line interface tools](#command-line-interface-tools)
  * [MacOS GUI tools](#macos-tools)
  * [Tools for Software and Cloud development](#tools-for-softwarecloud-development)
  * [System python packages](#python-packages)
* [Links](#links)


## System settings

Most of the System Settings can be changed by [MacOS defaults settings](https://github.com/revgen/myenv/tree/master/setup/macos/defaults).

### Terminal

Use bash instead of zsh: ```chsh -s /bin/bash```

### Keyboard

1. Preferences -> Keyboard:
1. Touch Bar shows: F1,F2...
1. Press Fn key to: Show Control Strip

### Security

1. Preferences -> Security & Privacy -> General: -> "Require Password" -> 
2. Set "Require Password - Immediately"
3. Check "Show a message when the screen is locked" (you need to unlock form first)
4. Set Lock Message, ex: "You name, phone number, email, address"

5. Preferences -> Security & Privacy -> FileVault: 
6. Turn On FileVault

### General

Theme

1. Preferences -> General:
1. Select "Appearance - Graphite"
1. Check - "Use dark menu bar and Dock"


Show scroll bars every time

1. Preferences -> General: ->
2. Select "Show scrool bars - Always"

### Desktop, Screensaver and Hot Corners

1. Preferences -> Desktop&Screensaver -> Screen Saver:
1. Select "Photos" screensaver type
1. Choose "Shigting Tiles" style

### Notifications

Disable preview for everything when locked


### Spotlight

On Spotlight settings:
* Check only what you need: Applications, Calculator, System Settings

On Search Privacy:
* Add directory to ignore: ~/Documents, ~/Workspace, /Volumes

### Accounts

* Add iCloud account
* Add Google account
* Add Microsoft account
* etc.


### Screenshots

Store all screenshots into the special ```Screenshots``` directory on the ```Desktop```.

```bash
mkdir -p "${HOME}/Desktop/Screenshots"
defaults write com.apple.screencapture disable-shadow -bool TRUE
defaults write com.apple.screencapture name "screenshot"
defaults write com.apple.screencapture location "${HOME}/Desktop/Screenshots"
killall SystemUIServer
echo "Show current screenshot location:"
defaults read com.apple.screencapture location
```

Ready to use script: [setup-screenshots-macos.sh](https://revgen.github.io/myenv/setup/macos/setup-screenshots-macos.sh)

## Tools

### Homebrew

Homebrew - The Missing Package Manager for macOS

* Install Homebrew
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

* Uninstall Homebrew
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
```

### Command Line Interface tools

| Command | Description |
| ---------------------------------------- | ---------------------------------------------------------- |
| brew install bash bash-completion        | [GNU Bash](https://www.gnu.org/software/bash/) |
| brew install neovim                      | [Hyperextensible Vim-based text editor](https://neovim.io/)|
| brew install inetutils                   | [GNU utilities for networking](https://www.gnu.org/software/inetutils/): telnet, ping, etc. |
| brew install git tig                     | [Git is distributed version control system](https://git-scm.com/) |
| brew install htop iftop                  | TUI monitoring tools: [htop](https://htop.dev/), [iftop](https://pdw.ex-parrot.com/iftop/) |
| brew install coreutils watch             | Different GNU cli tools: [coreutils](https://www.gnu.org/software/coreutils/), [watch](https://gitlab.com/procps-ng/procps)|
| brew install mc tree ncdu                | Work with directories and files: [mc](https://midnight-commander.org/), [tree](https://en.wikipedia.org/wiki/Tree_(command)), [ncdu](https://dev.yorhel.nl/ncdu)
| brew install inxi neofetch duf           | System information: [inxi](https://smxi.org/docs/inxi.htm), [duf](https://github.com/muesli/duf), [neofetch](https://en.wikipedia.org/wiki/Neofetch) |
| brew install gettext                     | GNU internationalization (i18n) and localization (l10n) [library](https://www.gnu.org/software/gettext/)|
| brew install wget lynx                   | Download and view web pages in terminal: [wget](https://www.gnu.org/software/wget/), [lynx](https://en.wikipedia.org/wiki/Lynx_(web_browser))|
| brew install unzip p7zip                 | Work with archives|
| brew install pv                          | Monitor data's progress through a pipe: [pv](https://www.ivarch.com/programs/pv.shtml)|
| brew install jq yq bat lnav              | File viewer and analyzer: [jq - json](https://jqlang.github.io/jq/), [yq - yaml](https://mikefarah.gitbook.io/yq), [bat - a cat with syntax highlighter](https://github.com/sharkdp/bat), [lnav - logs](https://lnav.org/) |
| brew install shellcheck                  | [Static analysis tool for shell scripts](https://www.shellcheck.net/) |
| brew install macos-trash                 | [Work with trash from terminal](https://github.com/sindresorhus/macos-trash) |
| brew install openssl                     | . |
| brew install speedtest-cli               | . |
| brew install httping                     | [A tool to measure RTT on HTTP/S requests](https://github.com/pjperez/httping) |
| brew install imagemagick                 | . |
| brew install ghostscript                 | [Interpreter for the PostScript®  language and PDF files](https://www.ghostscript.com/) |
| brew install ffmpeg mpv libcaca          | Watch video and/or listen audio from terminal |
| brew install yt-dlp                      | [Command-line audio/video downloader for youtube.com](https://github.com/yt-dlp/yt-dlp) |
| brew install cmatrix pipes-sh cbonsai    | Screensavers in terminal: [cmatrix](https://github.com/abishekvashok/cmatrix/), [pipes-sh](https://github.com/pipeseroni/pipes.sh), [cbonsai](https://gitlab.com/jallbrit/cbonsai) |
| brew install musikcube                   | [Fully functional terminal-based music player](https://musikcube.com/) |

### MacOS tools

| Command | Description |
| ---------------------------------------- | ---------------------------------------------------------- |
| brew install iterm2                      | [Better replacement for Terminal on MacOS](https://iterm2.com/) |
| • iTerms2 - [imgcat](https://iterm2.com/documentation-images.html) | ```curl -L https://www.iterm2.com/utilities/imgcat > ~/.local/bin/imgcat; chmod +x ~/.local/bin/imgcat``` |
| brew install google-chrome               | [Official web browser from Google](https://www.google.com/chrome/dr/download) |
| brew install google-drive                | [Cloud storage from Google](https://drive.google.com/) |
| brew install onedrive                    | [Cloud storage from Microsoft](https://www.microsoft.com/en-us/microsoft-365/onedrive/online-cloud-storage) |
| brew install megasync                    | [MEGA Cloud drives](https://mega.nz/sync) |
| brew install vlc                         | [Cross-platform multimedia player](https://www.videolan.org/vlc/) |
| brew install kid3                        | [Audio file tag editor](https://kid3.kde.org/) |
| brew install balenaetcher                | [A cross-platform tool to flash images onto SD cards and USB drives](https://www.balena.io/etcher) |
| brew install keepassxc                   | [A cross-platform password manager](https://keepassxc.org/) |
| brew install microsoft-remote-desktop    | [Microsoft remote desktop client for MacOS](https://learn.microsoft.com/en-us/windows-server/remote/remote-desktop-services/clients/remote-desktop-mac) |
| brew install vnc-viewer                  | [Real VNC viewer client](https://www.realvnc.com/) |
| brew install veracrypt                   | [Open-source and multi-platform disk encryption software](https://www.veracrypt.fr/code/VeraCrypt/) |
| brew install ytmdesktop-youtube-music    | [Youtube Music client](https://ytmdesktop.app/) |
| brew install freetube                    | [Free client for Youtube](https://freetubeapp.io/) |

### Tools for software/cloud development

| Command | Description |
| ---------------------------------------- | ---------------------------------------------------------- |
| brew install python@3.13                 | [Python Programming Language](https://python.org)|
| brew install openjdk@17                  | [Java is a high-level, class-based, object-oriented programming language](https://www.oracle.com/java/) |
| brew install node@22                     | [Node.js is a free, open-source, cross-platform JavaScript runtime environment](https://nodejs.org/en) |
| brew install awscli                      | [AWS Command Line Interface](https://aws.amazon.com/cli/) |
| brew cask install google-cloud-sdk       | [Google Cloud CLI]([https://aws.amazon.com/cli/](https://cloud.google.com/sdk/docs/install-sdk))|
| brew install oci-cli                     | [Oracle Cloud Infrastructure CLI](https://docs.cloud.oracle.com/iaas/Content/API/Concepts/cliconcepts.htm)|
| brew install azure-cli                   | [Azure Command-Line Interface](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-macos) |
| brew install visual-studio-code          | [It is a lightweight but powerful source code editor](https://code.visualstudio.com/) |
| brew install intellij-idea-ce            | [Popular Java and Kotlin IDE (Community Edition)](https://www.jetbrains.com/idea/) |

### Python packages

| Command | Description |
| ---------------------------------------------------- | ---------------------------------------------------------- |
| pip3 install python-dotenv --break-system-packages   | Manage environment variables in a .env file |
| pip3 install requests --break-system-packages        | Popular and powerfull library to work with HTTP requests |
| pip3 install termsaver --break-system-packages       | Provide simple [text-based screensavers](https://github.com/brunobraga/termsaver) for terminal windows|
| pip3 install visidata --break-system-packages        | [View data files in terminal](https://www.visidata.org/) |
| pip3 install ruff --break-system-packages            | An extremely fast [Python linter and code formatter](https://docs.astral.sh/ruff/) |

## Links

Resources where you can find an information about MacOS settings and tweaks

* https://www.defaults-write.com
* https://github.com/cfibmers/dotfiles/blob/master/osx/defaults.sh
* [Awesome MacOS Command Line Tools](https://github.com/herrbischoff/awesome-macos-command-line)
* [Hammerspoon](http://www.hammerspoon.org/) - powerful automation tool for Mac OS
* [Download macOS installer from the AppStore](https://support.apple.com/en-us/102662#appstore)
* [Create a bootable installer for macOS](https://support.apple.com/en-us/101578)
* [Find out which macOS your Mac is using](https://support.apple.com/en-us/109033)
* [MacOS Compatibility for Mac Computer (Mac Books or Desktops)](https://eshop.macsales.com/guides/Mac_OS_X_Compatibility)
* [Management profiles for OS X / macOS](https://github.com/rtrouton/profiles)



