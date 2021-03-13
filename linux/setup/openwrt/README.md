# OpenWRT





## Setup

### Install common tools
```bash
opkg update
opkg install htop
opkg install jq
opkg install rsync
# opkg has an old version of msmtp
wget -O /tmp/msmtp.ipk http://archive.openwrt.org/releases/18.06.1/packages/mips_24kc/packages/msmtp_1.8.7-1_mips_24kc.ipk
opkg install /tmp/msmtp.ipk
rm -f /tmp/msmtp.ipk
```

<details>
  <summary>Usefull script</summary>

### Custom startup
```bash
  vi /etc/rc.local
  # Add a new line at the end of the file
  echo "Started at $(date)" > /tmp/started.log &
```

### Backup OpenWrt configuration
```bash
umask go=
sysupgrade -b /tmp/backup-${HOSTNAME}-$(date +%F).tar.gz
ls /tmp/backup-*.tar.gz
```

### Restore OpenWrt configuration from the backup
```bash
sysupgrade -r /tmp/backup-YYY-MM-DD.tar.gz
```
<details>

## Links

* [OpenWRT](https://openwrt.com)