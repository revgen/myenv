# Additional apps for Ubuntu

```bash
sudo apt-get install -y keepassxc
#sudo apt-get install -y vim-gnome
sudo apt-get install -y gnome-terminal
sudo apt-get install -y mtpaint
# sudo apt-get install -y mypaint   - good for painter
sudo apt-get install -y xarchiver
sudo apt-get install -y evince
sudo apt-get install -y encfs
sudo apt-get install -y mplayer ffmpeg
sudo apt-get install -y webp imagemagick
sudo apt-get install -y youtube-dl
sudo apt-get install -y docker.io
sudo apt-get install -y
# support exfat
sudo apt-get install -y exfat-fuse exfat-utils
```

### Additional X tools
```
sudo apt-get install -y gnome-tweak-tool
```

### Install system information tool
```bash
sudo apt-get install -y inxi acpi
sudo apt-get install -y lm-sensors hddtemp
sudo sensors-detect
# after that you can use: sensors or hddtemp
```

### Install docker
```bash
sudo apt-get install -y docker.io
```

### Support exFAT, NTFS, and HFS+ file systems
```
sudo apt-get install exfat-fuse exfat-utils
sudo apt-get install ntfs-3g
sudo apt-get install hfsprogs
```
Mounting
```
sudo mount -t exfat /dev/sdc1 /media/exfat
sudo mount -t ntfs -o nls=utf8,umask=0222 /dev/sdb1 /media/windows
sudo mount -t hfsplus -o force,rw /dev/sdx# /media/mntpoint
```

APFS - [apfs-fuse](https://github.com/sgan81/apfs-fuse)

### Install wallpapers and resources

```
wget -O /tmp/wallpaper-283C50.png "http://dummyimage.com/32x32/283C50/283C50.png"
sudo mv -f /tmp/wallpaper-283C50.png /usr/share/backgrounds/
```

