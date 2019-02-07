#!/bin/sh
echo "You can add a custom message to the login/lock window."
echo "Current message is:"
msg=$(defaults read /Library/Preferences/com.apple.loginwindow LoginwindowText)
echo "----------------------------------------"
echo "${msg:-"<EMPTY>"}"
echo "----------------------------------------"
read -p "Do you want to update it (y/N)? " opt
if [ "${opt:-"N"}" == "Y" ] || [ "${opt}" == "y" ]; then
    echo "Input a new custom message what you wont see o the login/lock screen:"
    read -e msg
    echo "You need a root permission to write this new message into the system"
    sudo defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText "${msg}"

    echo "The new message is: "
    msg=$(defaults read /Library/Preferences/com.apple.loginwindow LoginwindowText)
    echo "----------------------------------------"
    echo "${msg:-"<EMPTY>"}"
    echo "----------------------------------------"
else
    echo "Skip"
fi
