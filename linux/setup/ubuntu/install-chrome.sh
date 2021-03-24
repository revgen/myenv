#!/bin/sh

deb=/tmp/chrome.deb
echo "Download Chrome 64bit" &&
wget -c -O "${deb}" https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb || exit 1
echo "Install deb package: ${deb}"
sudo dpkg -i "${deb}" && \
echo "Clean-up" && \
rm -f "${deb}" && \
echo "Success"

