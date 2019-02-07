#!/bin/sh
DEFAULT_TERMINAL_WIDTH=120
DEFAULT_TERMINAL_HEIGHT=35

echo "Setup default settings for Terminal.app"
echo "* Using a utf-8 in Terminal.app"
defaults write com.apple.terminal StringEncodings -array 4
echo "* Using 'Simple' as a default profile"
defaults write com.apple.terminal "Startup Window Settings" -string "Simple"
defaults write com.apple.terminal "Default Window Settings" -string "Simple"
echo "* Setup a default terminal size"
# defaults write com.apple.terminal columnCount -int ${DEFAULT_TERMINAL_WIDTH}
# defaults write com.apple.terminal rowCount -int ${DEFAULT_TERMINAL_HEIGHT}
/usr/libexec/PlistBuddy -c "Delete :Window\ Settings:Simple:columnCount" /Users/$USER/Library/Preferences/com.apple.Terminal.plist 2>/dev/null
/usr/libexec/PlistBuddy -c "Add :Window\ Settings:Simple:columnCount integer ${DEFAULT_TERMINAL_WIDTH}" /Users/$USER/Library/Preferences/com.apple.Terminal.plist
/usr/libexec/PlistBuddy -c "Delete :Window\ Settings:Simple:rowCount" /Users/$USER/Library/Preferences/com.apple.Terminal.plist 2>/dev/null
/usr/libexec/PlistBuddy -c "Add :Window\ Settings:Simple:rowCount integer ${DEFAULT_TERMINAL_HEIGHT}" /Users/$USER/Library/Preferences/com.apple.Terminal.plist
/usr/libexec/PlistBuddy -c "Delete :Window\ Settings:Simple:Bell" /Users/$USER/Library/Preferences/com.apple.Terminal.plist 2>/dev/null
/usr/libexec/PlistBuddy -c "Add :Window\ Settings:Simple:Bell bool false" /Users/$USER/Library/Preferences/com.apple.Terminal.plist
/usr/libexec/PlistBuddy -c "Delete :Window\ Settings:Simple:VisualBell" /Users/$USER/Library/Preferences/com.apple.Terminal.plist 2>/dev/null
/usr/libexec/PlistBuddy -c "Add :Window\ Settings:Simple:VisualBell bool false" /Users/$USER/Library/Preferences/com.apple.Terminal.plist
/usr/libexec/PlistBuddy -c "Save" /Users/$USER/Library/Preferences/com.apple.Terminal.plist

echo "* Show tab bar everytime"
defaults write com.apple.terminal ShowTabBar -int 1
echo "* Setup action: 'When shell exits' -> 'close the window'"
defaults write com.apple.terminal shellExitAction -int 0

echo "Restart CFPreferences and Terminal"
killall cfprefsd > /dev/null 2>&1
killall Terminal > /dev/null 2>&1
/usr/bin/open -a Terminal.app "${PWD}"
echo "Done"
