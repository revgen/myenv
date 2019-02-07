#!/bin/sh
USER_BIN=${USER_BIN:-"${HOME}/.local/bin"}
cd ${USER_BIN}
name=inxi
url=http://smxi.org/inxi
echo "Download inxi tool from ${url}..."
rm inxi 2>/dev/null
wget -qO inxi ${url} \
    && echo "Download complete" \
    && chmod +x inxi \
    && ls -l ${USER_BIN}/inxi \
    && echo "Success."


echo "Install dmidecode"
brew install cavaliercoder/dmidecode/dmidecode && \
echo "Success"