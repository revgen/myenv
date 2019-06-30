#!/bin/sh
USER_BIN=${USER_BIN:-"${HOME}/.local/bin"}
cd ${USER_BIN}
name=lnk-parse
url="https://raw.githubusercontent.com/lcorbasson/lnk-parse/master/lnk-parse.pl"
wget -qO ${name} "${url}" \
    && echo "Download complete" \
    && chmod +x ${name} \
    && ls -l ${USER_BIN}/${name} \
    && echo "Success."

