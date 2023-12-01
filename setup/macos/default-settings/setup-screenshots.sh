#!/bin/sh
SCREEENSHOT_LOCATION=${HOME}/Desktop/Screenshots
echo "Update MacOS screenshot settings"
echo ""

echo "* Location for screenshots: ${SCREENSHOT_LOCATION}"
mkdir -p "${SCREEENSHOT_LOCATION}" 2>/dev/null
echo ""

readmefile="${SCREEENSHOT_LOCATION}/README.txt"
echo "* Create README.txt file inside the ${SCREEENSHOT_LOCATION} directory"
echo "========================================================================" > "${readmefile}"
echo " To create a screenshot on your Mac:" >> "${readmefile}"
echo "========================================================================" >> "${readmefile}"
echo "* [Shift+Command+5] - Capture a screenshot with control window." >> "${readmefile}"
echo "* [Shift+Command+3] - Capture a screenshot of the whole screen to the ${SCREEENSHOT_LOCATION} directory." >> "${readmefile}"
echo "* [Shift+Command+4] - Select an area and capture a screenshot to the ${SCREEENSHOT_LOCATION} directory." >> "${readmefile}"
echo "See 'How to take a screenshot on your Mac' on the https://support.apple.com/en-us/HT201361" >> "${readmefile}"
cat "${readmefile}"
echo ""

echo "* Disable drop shadows on a screenshot"
defaults write com.apple.screencapture disable-shadow -bool TRUE

echo "* Writing new screenshot location to the OS settings..."
defaults write com.apple.screencapture name "screenshot"
defaults write com.apple.screencapture location "${SCREEENSHOT_LOCATION}" && \
killall SystemUIServer && \
echo "Success. Location=$(defaults read com.apple.screencapture location )"
# open -a Finder.app --args "${SCREENSHOT_LOCATION}"
open "https://support.apple.com/en-us/HT201361"



find "${SCREEENSHOT_LOCATION}" -mtime +1 | 
