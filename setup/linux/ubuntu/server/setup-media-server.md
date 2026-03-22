# Setup Media Server

## Setup firewall

```bash
# plex
sudo ufw allow 32400
# minidlna
sudo ufw allow 1883
sudo ufw allow 1900/udp
sudo ufw allow 8200
# transmission
sudo ufw allow 9091
```

## Install plex

> TBD

## Install minidlna

```bash
wget -O /tmp/minidlna https://raw.githubusercontent.com/revgen/docker/master/docker-minidlna/minidlna
chmod +x /tmp/minidlna
sudo mv -v /tmp/minidlna /usr/bin/minidlna

export DLNA_VIDEO_STORAGE=/mnt/storage/media/Video
export DLNA_MUSIC_STORAGE=/mnt/storage/media/Music
export DLNA_IMAGES_STORAGE=/mnt/storage/photos
export DLNA_DOWNLOADS_STORAGE=/mnt/storage/downloads
export DLNA_SERVER_NAME="$(hostname)"
minidlna create && minidlna start
```

## Install TimeMachine

> Obsolete!!!

```bash
wget -O /tmp/timemachine https://raw.githubusercontent.com/revgen/docker/master/docker-timemachine/timemachine
chmod +x /tmp/timemachine
sudo mv -v /tmp/timemachine /usr/bin/timemachine

export SMB_NAME="$(hostname)-TM"
export SMB_USER="tm"
export SMB_PASSWORD="pass1234"
export TM_DIRECTORY=/mnt/backup/timemachine
timemachine create && timemachine start
```

### Install transmission

```bash
wget -O /tmp/transmission https://raw.githubusercontent.com/revgen/docker/master/docker-transmission/transmission
chmod +x /tmp/transmission
sudo mv -v /tmp/transmission /usr/bin/transmission
#fix transmission permissions:
sudo chown ${USER}:users -R "${HOME}/.docker"

transmission create && transmission start
```
