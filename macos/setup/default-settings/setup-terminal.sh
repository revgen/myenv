#!/usr/bin/env bash
line() { echo "########################################################################"; }
title() { line; echo "# ${1}"; line; }
ask() { read -n 1 -p "${1} (y/N)? " opt; [ "${opt}" == "y" ] && echo " - OK"; }
skipped() { echo " - Skipped"; }

# -----------------------------------------------------------------------------
title "Terminal"
DEFAULT_TERMINAL_WIDTH=120
DEFAULT_TERMINAL_HEIGHT=35
DEFAULT_TERMINAL_PROFILE=Basic
ask "* Using a utf-8 in Terminal.app" && \
    defaults write com.apple.terminal StringEncodings -array 4 || skipped
ask "* Using '${DEFAULT_TERMINAL_PROFILE}' as a default profile" && \
    defaults write com.apple.terminal "Startup Window Settings" -string "${DEFAULT_TERMINAL_PROFILE}" && \
    defaults write com.apple.terminal "Default Window Settings" -string "${DEFAULT_TERMINAL_PROFILE}" || skipped
ask "* Setup a default terminal size (${DEFAULT_TERMINAL_WIDTH}x${DEFAULT_TERMINAL_HEIGHT})" && \
    /usr/libexec/PlistBuddy -c "Delete :Window\ Settings:${DEFAULT_TERMINAL_PROFILE}:columnCount" /Users/$USER/Library/Preferences/com.apple.Terminal.plist 2>/dev/null && \
    /usr/libexec/PlistBuddy -c "Add :Window\ Settings:${DEFAULT_TERMINAL_PROFILE}:columnCount integer ${DEFAULT_TERMINAL_WIDTH}" /Users/$USER/Library/Preferences/com.apple.Terminal.plist  && \
    /usr/libexec/PlistBuddy -c "Delete :Window\ Settings:${DEFAULT_TERMINAL_PROFILE}:rowCount" /Users/$USER/Library/Preferences/com.apple.Terminal.plist 2>/dev/null && \
    /usr/libexec/PlistBuddy -c "Add :Window\ Settings:${DEFAULT_TERMINAL_PROFILE}:rowCount integer ${DEFAULT_TERMINAL_HEIGHT}" /Users/$USER/Library/Preferences/com.apple.Terminal.plist || skipped
ask "* Disable Bells" && \
    /usr/libexec/PlistBuddy -c "Delete :Window\ Settings:${DEFAULT_TERMINAL_PROFILE}:Bell" /Users/$USER/Library/Preferences/com.apple.Terminal.plist 2>/dev/null && \
    /usr/libexec/PlistBuddy -c "Add :Window\ Settings:${DEFAULT_TERMINAL_PROFILE}:Bell bool false" /Users/$USER/Library/Preferences/com.apple.Terminal.plist && \
    /usr/libexec/PlistBuddy -c "Delete :Window\ Settings:${DEFAULT_TERMINAL_PROFILE}:VisualBell" /Users/$USER/Library/Preferences/com.apple.Terminal.plist 2>/dev/null && \
    /usr/libexec/PlistBuddy -c "Add :Window\ Settings:${DEFAULT_TERMINAL_PROFILE}:VisualBell bool false" /Users/$USER/Library/Preferences/com.apple.Terminal.plist || skipped
ask "* Use 'Option' key as 'Meta' key" && \
    /usr/libexec/PlistBuddy -c "Delete :Window\ Settings:${DEFAULT_TERMINAL_PROFILE}:useOptionAsMetaKey" /Users/$USER/Library/Preferences/com.apple.Terminal.plist 2>/dev/null && \
    /usr/libexec/PlistBuddy -c "Add :Window\ Settings:${DEFAULT_TERMINAL_PROFILE}:useOptionAsMetaKey bool true" /Users/$USER/Library/Preferences/com.apple.Terminal.plist || skipped
/usr/libexec/PlistBuddy -c "Save" /Users/$USER/Library/Preferences/com.apple.Terminal.plist
ask "* Show tab bar all the time" && \
    defaults write com.apple.terminal ShowTabBar -int 1 || skipped
ask "* Setup action: 'When shell exits' -> 'close the window'" && \
    defaults write com.apple.terminal shellExitAction -int 0 || skipped

# -----------------------------------------------------------------------------
title "Restart CFPreferences and Terminal"
killall cfprefsd > /dev/null 2>&1
killall Terminal > /dev/null 2>&1
/usr/bin/open -a Terminal.app "${PWD}"
echo "Done"
