#!/bin/sh

deb=/tmp/chrome.deb
if [ "$(uname -i)" = "x86_64" ]; then
    echo "Download Chrome 64bit" &&
    wget -c -O "${deb}" https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb || exit 1
else
    echo "Download Chrome 32bit"
    wget -c -O "${deb}" https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb || exit 1
fi
echo "Install deb package: ${deb}"
sudo dpkg -i "${deb}" && \
echo "Clean-up" && \
rm -f "${deb}" && \
echo "Success"

