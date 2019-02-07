#!/bin/sh

[ ! -d "${HOME}/Downloads" ] && mkdir "${HOME}/Downloads" && echo "Created ${HOME}/Downloads"
cd ${HOME}/Downloads
echo "Download SomaFM playlists"
wget "https://somafm.com/spacestation.pls"
wget "https://somafm.com/missioncontrol.pls"
wget "https://somafm.com/seventies.pls"
wget "https://somafm.com/indiepop.pls"
wget "https://somafm.com/u80s.pls"
wget "https://somafm.com/folkfwd.pls"
wget "https://somafm.com/secretagent.pls"
wget "https://somafm.com/defcon130.pls"
wget "https://somafm.com/fluid.pls"
wget ""
