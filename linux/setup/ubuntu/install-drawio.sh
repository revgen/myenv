#!/bin/sh

deb=/tmp/drawio.deb
echo "Download package"
wget -c -O "${deb}" "https://github.com/jgraph/drawio-desktop/releases/download/v13.0.3/draw.io-amd64-13.0.3.deb" || exit 1
echo "Install deb package: ${deb}"
sudo dpkg -i "${deb}" && \
echo "Clean-up" && \
rm -f "${deb}" && \
echo "Success"

