#!/bin/sh
echo "Write defauls setting"
defaults write com.apple.finder AppleShowAllFiles -bool TRUE
echo "Restart Finder"
killall Finder
