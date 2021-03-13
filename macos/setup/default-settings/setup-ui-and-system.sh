#!/usr/bin/env bash
line() { echo "########################################################################"; }
title() { line; echo "# ${1}"; line; }
ask() { read -n 1 -p "${1} (y/N)? " opt; [ "${opt}" == "y" ] && echo " - OK"; }
skipped() { echo " - Skipped"; }

# -----------------------------------------------------------------------------
title "General UI/UX settings"
ask "* Always show scrollbars: Preferences -> General: -> 'Show scrool bars - Always'" && \
    defaults write NSGlobalDomain AppleShowScrollBars -string "Always" || skipped
ask "* Sidebar icon size: medium" && \
    defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2 || skipped
    # 1 - small, 2 - medium, 3 - large
ask "* Using a Dark mode" && \
    defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark" && \
    defaults write NSGlobalDomain AppleAquaColorVariant -int 6 || skipped
    # Appearance: 1 - Blue, 6 - Graphite
ask "* Enable subpixel font rendering on non-Apple LCDs" && \
    defaults write NSGlobalDomain AppleFontSmoothing -int 2 || skipped
ask "* Show battery percentage" && \
    defaults write com.apple.menuextra.battery ShowPercent YES || skipped
echo ""

# -----------------------------------------------------------------------------
title "Launchpad and Panel"
ask "* Change Grid Layout For LaunchPad On Mac OS X (5x4) (default is 7x5)" && \
    defaults write com.apple.dock springboard-columns -int 5 && \
    defaults write com.apple.dock springboard-rows -int 4 || skipped
ask "* Default clock format in the panel (WeekDay Month Day Year Time)" && \
    defaults write com.apple.menuextra.clock DateFormat -string "EEE MMM d  H:mm" && \
    defaults write com.apple.menuextra.clock FlashDateSeparators -bool false && \
    defaults write com.apple.menuextra.clock IsAnalog -bool false || skipped
# Reset the Launchpad
defaults write com.apple.dock ResetLaunchPad -bool TRUE
echo ""

# -----------------------------------------------------------------------------
title "Hot corners"
# Possible values: 0 - no-op, 1 - Empty, 2 - Mission Control, 3 - Show application windows,
# 4 - Desktop, 5 - Start screen saver, 6 - Disable screen saver, 7 - Dashboard,
# 10 - Put display to sleep, 11 - Launchpad, 12: Notification Center, 13: Lock screen
ask "* Add 'Start Screensaver' into the top-left corner" && \
    defaults write com.apple.dock wvous-tl-corner -int 5 && \
    defaults write com.apple.dock wvous-tl-modifier -int 0 || skipped
ask "* Add 'Desktop' into the top-right corner" && \
    defaults write com.apple.dock wvous-tr-corner -int 4 && \
    defaults write com.apple.dock wvous-tr-modifier -int 1048576 || skipped
ask "* Add 'Show Dashboard' into the bottom-left corner" && \
    defaults write com.apple.dock wvous-bl-corner -int 13 && \
    defaults write com.apple.dock wvous-bl-modifier -int 0 || skipped
ask "* Add 'nothing' into the bottom-right corner" && \
    defaults write com.apple.dock wvous-br-corner -int 1 && \
    defaults write com.apple.dock wvous-br-modifier -int 1048576 || skipped
echo ""

# -----------------------------------------------------------------------------
title "Dock"
ask "* Set position the Dock on the left" && \
    defaults write com.apple.dock orientation left || skipped
ask "* Set the icon size of Dock items to 40 px and enable Magnification to 60 px" && \
    defaults write com.apple.dock tilesize -int 40 && \
    defaults write com.apple.dock magnification -bool true && \
    defaults write com.apple.dock largesize -int 60 || skipped
ask "* Show indicator lights for open applications" && \
    defaults write com.apple.dock show-process-indicators -bool true || skipped
ask "* Show all app in the Dock (hidden too)" && \
    defaults write com.apple.Dock showhidden -bool TRUE || skipped
ask "* Don’t animate opening applications" && \
    defaults write com.apple.dock launchanim -bool false || skipped
ask "* Use the scale effect for window minimizing" && \
    defaults write com.apple.dock mineffect scale || skipped
ask "* Speed up Mission Control animations" && \
    defaults write com.apple.dock expose-animation-duration -float 0.1 || skipped
ask "* Don’t automatically rearrange Spaces based on most recent use" && \
    defaults write com.apple.dock mru-spaces -bool false || skipped
ask "* Don't show recent application in the dock" && \
    defaults write com.apple.dock show-recents -bool false || skipped
ask "* Do not hide non-active apps in your Dock" && \
    defaults write com.apple.dock static-only -bool FALSE || skipped
ask "* Dock: Wipe all (default) app icons from the Dock" && \
    defaults write com.apple.dock persistent-apps -array || skipped
echo ""

# -----------------------------------------------------------------------------
title "System"
ask "* Security: Require a password immediately after sleep or screen saver begins" && \
    defaults write com.apple.screensaver askForPassword -int 1 && \
    defaults write com.apple.screensaver askForPasswordDelay -int 0 || skipped
    # On UI: Preferences -> Security & Privacy -> General: -> "Require Password" -> 2. Set "Require Password - Immediately"
ask "* Printer: Expand printer panel by default" && \
    defaults write -g PMPrintingExpandedStateForPrint -bool true || skipped
ask "* Printer: Automatically quit printer app once the print jobs complete"
    defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true || skipped
ask "* Keyboard: Disable auto-correct" && \
    defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false || skipped
ask "* Keyboard: Enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)" && \
    defaults write NSGlobalDomain AppleKeyboardUIMode -int 3 || skipped
ask "* Keyboard: Turn on key repeat (Disable hold modifier)" && \
    defaults write -g ApplePressAndHoldEnabled -int 0 || skipped
ask "* Keyboard: Use all F1, F2, etc. keys as standard function keys" && \
    defaults write NSGlobalDomain "com.apple.keyboard.fnState" -bool true || skipped
echo ""

# -----------------------------------------------------------------------------
title "Restart all related applications"
for app in "cfprefsd" "Dashboard" "Dock" "Finder" "SystemUIServer"; do
    killall "$app" > /dev/null 2>&1
done
echo ""
echo "Done"
