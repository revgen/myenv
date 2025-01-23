#!/usr/bin/env bash
line() { echo "########################################################################"; }
title() { line; echo "# ${1}"; line; }
ask() { read -n 1 -p "${1} (y/N)? " opt; [ "${opt}" == "y" ] && echo " - OK"; }
skipped() { echo " - Skipped"; }

# -----------------------------------------------------------------------------
title "Finder"
ask "* Remove items from the Trash after 30 days" && \
    defaults write com.apple.finder FXRemoveOldTrashItems -bool true || skipped
    # Finder -> Preferences -> Advanced -> “Remove items from the Trash after 30 days”
ask "* Use Finders list view as the default view mode" && \
    defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv" || skipped
    # Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
ask "* Show path bar and status bar" && \
    defaults write com.apple.finder ShowPathbar -int 1 && \
    defaults write com.apple.finder ShowStatusBar -int 1 || skipped
ask "* Show all filename extensions" && \
    defaults write NSGlobalDomain AppleShowAllExtensions -bool true && \
    defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false || skipped
ask "* Expand save panel by default" && \
    defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -int 1 && \
    defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -int 1 || skipped
ask "* Disable window and Get Info animations" && \
    defaults write com.apple.finder DisableAllAnimations -bool true || skipped
ask "* Keep folders on top when sorting by name" && \
    defaults write com.apple.finder _FXSortFoldersFirst -bool true || skipped
ask "* Allow quitting via ⌘ + Q; doing so will also hide desktop icons" && \
    defaults write com.apple.finder QuitMenuItem -bool true || skipped
ask "* Remove items from the Trash after 30 days" && \
    defaults write com.apple.finder FXRemoveOldTrashItems -bool true || skipped
ask "* Set Home as the default location for new Finder windows" && \
    defaults write com.apple.finder NewWindowTarget -string "PfLo" && \
    defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}" || skipped
ask "* Allow text selection in Quick Look" && \
    defaults write com.apple.finder QLEnableTextSelection -bool true || skipped
  # echo "* show hidden files by default"
  #defaults write com.apple.finder AppleShowAllFiles -bool true
ask "* Enable snap-to-grid for icons on the desktop and in other icon views" && \
    /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist && \
    /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist && \
    /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist || skipped
ask "* Show icons for hard drives, servers, and removable media on the desktop" && \
    defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true && \
    defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false && \
    defaults write com.apple.finder ShowMountedServersOnDesktop -bool true && \
    defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true || skipped
ask "* System: Save to disk (not to iCloud) by default" && \
    defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false || skipped
ask "* System: Avoid creating .DS_Store files on network volumes" && \
    defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true || skipped
ask "* System: Stop Photos from opening automatically on your Mac when you connect an iPhone, iPad and etc." && \
    defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true || skipped
echo ""

# -----------------------------------------------------------------------------
title "Safari"
ask "* Privacy: don’t send search queries to Apple" && \
    defaults write com.apple.Safari UniversalSearchEnabled -bool false && \
    defaults write com.apple.Safari SuppressSearchSuggestions -bool true || skipped
ask "* Press Tab to highlight each item on a web page" && \
    defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true && \
    defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true || skipped
ask "* Enable the Develop menu and the Web Inspector in Safari" && \
    defaults write com.apple.Safari IncludeInternalDebugMenu -bool true && \
    defaults write com.apple.Safari IncludeDevelopMenu -bool true && \
    defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true && \
    defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true || skipped
ask "* Show the full URL in the address bar (note: this still hides the scheme)" && \
    defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true || skipped
ask "* Disable the standard delay in rendering a Web page" && \
    defaults write com.apple.Safari WebKitInitialTimedLayoutDelay 0.25 || skipped
ask "* Allow hitting the Backspace key to go to the previous page in history" && \
    defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true || skipped
ask "* Add a context menu item for showing the Web Inspector in web views" && \
    defaults write NSGlobalDomain WebKitDeveloperExtras -bool true || skipped
echo ""

# -----------------------------------------------------------------------------
title "Activity Monitor"
ask "* Show the main window when launching Activity Monitor" && \
    defaults write com.apple.ActivityMonitor OpenMainWindow -bool true || skipped
ask "* Visualize CPU usage in the Activity Monitor Dock icon" && \
    defaults write com.apple.ActivityMonitor IconType -int 5 || skipped
ask "* Show all processes in Activity Monitor" && \
    defaults write com.apple.ActivityMonitor ShowCategory -int 0 || skipped
ask "* Sort Activity Monitor results by CPU usage" && \
    defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage" && \
    defaults write com.apple.ActivityMonitor SortDirection -int 0 || skipped
echo ""

# -----------------------------------------------------------------------------
title "TextEdit"
ask "* Use plain text mode for new TextEdit documents" && \
    defaults write com.apple.TextEdit RichText -int 0 && \
    defaults write com.apple.TextEdit AddExtensionToNewPlainTextFiles -int 0 && \
    defaults write com.apple.TextEdit IgnoreHTML -int 1 || skipped
ask "* Open and save files as UTF-8 in TextEdit" && \
    defaults write com.apple.TextEdit PlainTextEncoding -int 4 && \
    defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4 || skipped
ask " * Windows size 120x40" && \
    defaults write com.apple.TextEdit WidthInChars -int 120 && \
    defaults write com.apple.TextEdit HeightInChars -int 40 || skipped
ask " * Font CourierNew 14" && \
    defaults write com.apple.TextEdit NSFixedPitchFont -string "CourierNewPSMT" && \
    defaults write com.apple.TextEdit NSFixedPitchFontSize -int 14 || skipped
ask " * Disable automatic spelling correction" && \
    defaults write com.apple.TextEdit CorrectSpellingAutomatically -int 0 || skipped
ask " * Disable autosave" && \
    defaults write -app textedit ApplePersistence -bool no && \
    defaults write -app textedit AutosavingDelay -int 0 || skipped
echo ""

echo "Done"
