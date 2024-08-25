# Setup Nextcloud

## Download nextcloud cli script
```bash
wget https://raw.githubusercontent.com/revgen/docker/master/docker-nextcloud/nextcloud
chmod +x nextcloud
sudo mv -v nextcloud /usr/local/bin/

sudo ufw allow 9180
```

## Create/Update storage directory
```bash
sudo mkdir /mnt/data/nextcloud
cd /mnt/data/nextcloud
sudo chown ${USER}:${USER} -R ./
```

## Create/Update configuration
```bash
mkdir "${HOME}/.config/" 2>/dev/null
cd /mnt/data/nextcloud
nextcloud config > /tmp/nextcloud.conf
cat /tmp/nextcloud.conf >> "${HOME}/.config/nextcloud.conf"
vim "${HOME}/.config/nextcloud.conf"
```

## Run nextcloud container
```bash
cd /mnt/data/nextcloud
nextcloud create
nextcloud start
```
