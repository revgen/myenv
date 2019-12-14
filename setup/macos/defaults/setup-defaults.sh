#!/bin/sh
HOSTNAME=${1:-"${HOSTNAME:-$(scutil --get HostName)}"}

echo "########################################################################"
echo "# General UI/UX settings                                               #"
echo "########################################################################"
echo "* Set computer name (as done via System Preferences → Sharing) to: ${HOSTNAME}"
    sudo scutil --set ComputerName "${HOSTNAME}"
    sudo scutil --set HostName "${HOSTNAME}"
    sudo scutil --set LocalHostName "${HOSTNAME}"
    sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "${HOSTNAME}"

echo "* Disable Fast User Switching (hide on the panel, near the clock)"
    sudo defaults write /Library/Preferences/.GlobalPreferences MultipleSessionEnabled -bool NO

echo "* Always show scrollbars: Preferences -> General: -> 'Show scrool bars - Always'"
    defaults write NSGlobalDomain AppleShowScrollBars -string "Always"
echo "* Sidebar icon size: medium"
    # 1 - small, 2 - medium, 3 - large
    defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2
echo "* Using a Dark mode"
    defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"
    # Appearance: 1 - Blue, 6 - Graphite
    defaults write NSGlobalDomain AppleAquaColorVariant -int 6
echo "* Save to disk (not to iCloud) by default"
    defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
echo "* Printer: Expand printer panel by default"
    defaults write -g PMPrintingExpandedStateForPrint -bool true
echo "* Printer: Automatically quit printer app once the print jobs complete"
    defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true
echo "* Disable auto-correct"
    defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
echo "* Enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)"
    defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
echo "* Turn on key repeat (Disable hold modifier)"
    defaults write -g ApplePressAndHoldEnabled -int 0
echo "* Disable the sound effects on boot (need root to setup)"
    sudo nvram SystemAudioVolume=" "
echo "* Require a password immediately after sleep or screen saver begins"
    # On UI: Preferences -> Security & Privacy -> General: -> "Require Password" -> 2. Set "Require Password - Immediately"
    defaults write com.apple.screensaver askForPassword -int 1
    defaults write com.apple.screensaver askForPasswordDelay -int 0
echo "* Avoid creating .DS_Store files on network volumes"
    defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
echo "* Stop Photos from opening automatically on your Mac when you connect an iPhone, iPad and etc."
    defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true
echo "* Enable subpixel font rendering on non-Apple LCDs"
    defaults write NSGlobalDomain AppleFontSmoothing -int 2
echo "* Use all F1, F2, etc. keys as standard function keys"
    defaults write NSGlobalDomain "com.apple.keyboard.fnState" -bool true
echo "* Show battery percentage"
    defaults write com.apple.menuextra.battery ShowPercent YES

echo "Restart all related applications"
    for app in "cfprefsd" "Dashboard" "Dock" "Finder" "SystemUIServer"; do
        killall "$app" > /dev/null 2>&1
    done

echo ""
echo "########################################################################"
echo "# Dock                                                                 #"
echo "########################################################################"
#echo "* Set position the Dock on the left"
#    defaults write com.apple.dock orientation left
echo "* Set the icon size of Dock items to 40 pixels"
    defaults write com.apple.dock tilesize -int 40
echo "* Magnification settings"
    defaults write com.apple.dock magnification -bool true
    defaults write com.apple.dock largesize -int 60
echo "* Show indicator lights for open applications"
    defaults write com.apple.dock show-process-indicators -bool true
echo "* Show all app in the Dock (hidden too)"
    defaults write com.apple.Dock showhidden -bool TRUE
echo "* Don’t animate opening applications"
    defaults write com.apple.dock launchanim -bool false
echo "* Use the scale effect for window minimizing"
    defaults write com.apple.dock mineffect scale
echo "* Speed up Mission Control animations"
    defaults write com.apple.dock expose-animation-duration -float 0.1
echo "* Don’t automatically rearrange Spaces based on most recent use"
    defaults write com.apple.dock mru-spaces -bool false
echo "* Don't show recent aplication in the dock"
    defaults write com.apple.dock show-recents -bool false
echo "* Do not hide non-active apps in your Dock"
    defaults write com.apple.dock static-only -bool FALSE
echo "* Dock: Wipe all (default) app icons from the Dock"
    defaults write com.apple.dock persistent-apps -array
echo "Restart dock"
    killall Dock

echo ""
echo "########################################################################"
echo "# Launchpad and Panel                                                  #"
echo "########################################################################"
echo "* Change Grid Layout For LaunchPad On Mac OS X (5x4) (default is 7x5)"
    defaults write com.apple.dock springboard-columns -int 5
    defaults write com.apple.dock springboard-rows -int 4
echo "* Default clock format in the panel (WeekDay Month Day Year Time)"
    defaults write com.apple.menuextra.clock DateFormat -string "EEE MMM d  H:mm"
    defaults write com.apple.menuextra.clock FlashDateSeparators -bool false
    defaults write com.apple.menuextra.clock IsAnalog -bool false
echo "Reset the Launchpad"
    defaults write com.apple.dock ResetLaunchPad -bool TRUE
    killall Dock

echo ""
echo "########################################################################"
echo "# Hot corners                                                          #"
echo "########################################################################"
# Possible values: 0 - no-op, 1 - Empty, 2 - Mission Control, 3 - Show application windows,
# 4 - Desktop, 5 - Start screen saver, 6 - Disable screen saver, 7 - Dashboard,
# 10 - Put display to sleep, 11 - Launchpad, 12: Notification Center
echo "* Add 'Start Screensaver' into the top-left corner"
    defaults write com.apple.dock wvous-tl-corner -int 5
    defaults write com.apple.dock wvous-tl-modifier -int 0
echo "* Add 'nothing' into the top-right corner"
    defaults write com.apple.dock wvous-tr-corner -int 1
    defaults write com.apple.dock wvous-tr-modifier -int 1048576
echo "* Add 'Show Dashboard' into the bottom-right corner"
    defaults write com.apple.dock wvous-bl-corner -int 7
    defaults write com.apple.dock wvous-bl-modifier -int 0
echo "* Add 'nothing' into the bottom-right corner"
    defaults write com.apple.dock wvous-br-corner -int 1
    defaults write com.apple.dock wvous-br-modifier -int 1048576
echo "Reset the Dock"
    killall Dock

echo ""
echo "########################################################################"
echo "# Finder                                                               #"
echo "########################################################################"
echo "* Use Finders list view as the default view mode"
    # Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
    defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
echo "* Show path bar and status bar"
    defaults write com.apple.finder ShowPathbar -int 1
    defaults write com.apple.finder ShowStatusBar -int 1
echo "* Show all filename extensions"
    defaults write NSGlobalDomain AppleShowAllExtensions -bool true
echo "* disable the warning when changing a file extension"
    defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
echo "* Expand save panel by default"
    defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -int 1
    defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -int 1
echo "* Disable window and Get Info animations"
    defaults write com.apple.finder DisableAllAnimations -bool true
echo "* Keep folders on top when sorting by name"
    defaults write com.apple.finder _FXSortFoldersFirst -bool true
echo "* Allow quitting via ⌘ + Q; doing so will also hide desktop icons"
    defaults write com.apple.finder QuitMenuItem -bool true
echo "* Remove items from the Trash after 30 days"
    defaults write com.apple.finder FXRemoveOldTrashItems -bool true
echo "* Set Home as the default location for new Finder windows"
    defaults write com.apple.finder NewWindowTarget -string "PfLo"
    defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}"
echo "* Allow text selection in Quick Look"
    defaults write com.apple.finder QLEnableTextSelection -bool true
# echo "* show hidden files by default"
#defaults write com.apple.finder AppleShowAllFiles -bool true
echo "* Enable snap-to-grid for icons on the desktop and in other icon views"
    /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
echo "* Show icons for hard drives, servers, and removable media on the desktop"
    defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
    defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
    defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
    defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
echo "Restart Finder"
    killall Finder

echo ""
echo "########################################################################"
echo "# Safari                                                               #"
echo "########################################################################"
echo "* Privacy: don’t send search queries to Apple"
    defaults write com.apple.Safari UniversalSearchEnabled -bool false
    defaults write com.apple.Safari SuppressSearchSuggestions -bool true
echo "* Press Tab to highlight each item on a web page"
    defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true
    defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true
echo "* Enable the Develop menu and the Web Inspector in Safari"
    defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
    defaults write com.apple.Safari IncludeDevelopMenu -bool true
    defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
    defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
echo "* Show the full URL in the address bar (note: this still hides the scheme)"
    defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true
echo "* Disable the standard delay in rendering a Web page"
    defaults write com.apple.Safari WebKitInitialTimedLayoutDelay 0.25
echo "* Allow hitting the Backspace key to go to the previous page in history"
    defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true
echo "* Add a context menu item for showing the Web Inspector in web views"
    defaults write NSGlobalDomain WebKitDeveloperExtras -bool true
echo "Close al Safari"
    killall Safari

echo ""
echo "########################################################################"
echo "# Activity Monitor                                                     #"
echo "########################################################################"
echo "* Show the main window when launching Activity Monitor"
    defaults write com.apple.ActivityMonitor OpenMainWindow -bool true
echo "* Visualize CPU usage in the Activity Monitor Dock icon"
    defaults write com.apple.ActivityMonitor IconType -int 5
echo "* Show all processes in Activity Monitor"
    defaults write com.apple.ActivityMonitor ShowCategory -int 0
echo "* Sort Activity Monitor results by CPU usage"
    defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
    defaults write com.apple.ActivityMonitor SortDirection -int 0

echo ""
echo "########################################################################"
echo "# TextEdit                                                             #"
echo "########################################################################"
echo "* Use plain text mode for new TextEdit documents"
    defaults write com.apple.TextEdit RichText -int 0
    defaults write com.apple.TextEdit AddExtensionToNewPlainTextFiles -int 0
    defaults write com.apple.TextEdit IgnoreHTML -int 1
echo "* Open and save files as UTF-8 in TextEdit"
    defaults write com.apple.TextEdit PlainTextEncoding -int 4
    defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4
echo " * Windows size 120x40"
    defaults write com.apple.TextEdit WidthInChars -int 120
    defaults write com.apple.TextEdit HeightInChars -int 40
echo " * Font CourierNew 14"
    defaults write com.apple.TextEdit NSFixedPitchFont -string "CourierNewPSMT"
    defaults write com.apple.TextEdit NSFixedPitchFontSize -int 14

echo "########################################################################"
echo "Done"
