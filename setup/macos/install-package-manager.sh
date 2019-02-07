#!/bin/sh
echo "==[ Install homebrew ]=================================================="
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "==[ Install Mac App Store command-line interface ]======================"
brew install mas
