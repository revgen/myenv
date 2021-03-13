#!/bin/bash
PASS_FILE=/etc/x11vnc.pass
CFG_FILE=/lib/systemd/system/x11vnc.service
LOG_FILE=/var/log/x11vnc.log
PORT=5900
title() { echo "============================================================"; echo $1; }

ALLOW_LOCALHOST_ACCESS_ONLY=1

ubuntu_version=$(lsb_release -r | awk '{print $2}' | head -c 2)
if [ -z "${ubuntu_version}" ] || [ $ubuntu_version -lt 15 ]; then
    echo "Wrong OS. This script can work on Ubuntu 15.4+"
    exit 1
fi

[ $UID -ne 0 ] && echo "You must be root to install x11vnc. Exit." && exit 1

title "Install x11vnc"
apt-get install x11vnc

title "Create password file"
x11vnc -storepasswd "${PASS_FILE}"

title "Create startup service configuration file"
echo -e "[Unit]
Description=x11vnc
Requires=display-manager.service
After=display-manager.service

[Service]" > "${CFG_FILE}"
if [ ${ALLOW_LOCALHOST_ACCESS_ONLY} -eq 1 ]; then
    echo "ExecStart=/usr/bin/x11vnc -xkb -repeat -noxrecord -noxdamage -display :0 -localhost -auth guess -forever -rfbauth ${PASS_FILE} -rfbport ${PORT} -o ${LOG_FILE}" >> "${CFG_FILE}"
else
    echo "ExecStart=/usr/bin/x11vnc -xkb -repeat -noxrecord -noxdamage -display :0 -auth guess -forever -rfbauth ${PASS_FILE} -rfbport ${PORT} -o ${LOG_FILE}" >> "${CFG_FILE}"
fi
echo -e "ExecStop=/usr/bin/killall x11vnc

[Install]
WantedBy=multi-user.target
" >> "${CFG_FILE}"

title "Restart service"
systemctl daemon-reload
systemctl start x11vnc
systemctl enable x11vnc

title "Add cron job for root to start x11vnc every minute if it not started"
[ -z "$(sudo cat /var/spool/cron/crontabs/root | grep "X11VNC stopped")" ] && \
  sudo sh -c 'echo "* * * * * ps -A | grep x11vnc || logger -t x11vnc \"X11VNC stopped.\" && systemctl start x11vnc" >> /var/spool/cron/crontabs/root'

title "Now you can connect to this warkstation via VNC using port ${PORT}"

