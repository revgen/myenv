#!/bin/sh
echo "Write defauls setting"
defaults write com.apple.finder AppleShowAllFiles -bool FALSE
echo "Restart Finder"
killall Finder
