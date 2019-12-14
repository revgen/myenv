#!/bin/sh
echo "==[ Install command line tool ]========================================="
xcode-select --install

if [ -n "$(which xcodebuild)" ]; then
    echo "==[ Agree to the XCode license ]========================================"
    sudo xcodebuild -license
fi

echo "==[ Install homebrew ]=================================================="
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "==[ Update homebrew ]==================================================="
brew update

echo "==[ Install Mac App Store command-line interface ]======================"
brew install mas

