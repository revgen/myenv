# Raspberry Pi

## Setup

## Users

### Add a new user

```bash
sudo useradd -m -s /bin/bash john
sudo usermod -a -G sudo,adm,users,gpio,spi,i2c,input,audio,video john
sudo passwd john
```

### Change privileges for the 'pi' user: make it lower

```bash
sudo usermod -G users,gpio,input,audio,video pi
```

### Install core tools

```bash
sudo apt update
sudo apt install -y wget curl mc htop jq screen tree elinks dialog nginx

wget -O /tmp/session https://raw.githubusercontent.com/revgen/myenv/master/home/.local/bin/session
chmod +x /tmp/session
sudo mv -v /tmp/session /usr/local/bin/
wget -O /tmp/sysinfo https://raw.githubusercontent.com/revgen/myenv/master/home/.local/bin/sysinfo
chmod +x /tmp/sysinfo
sudo mv -v /tmp/sysinfo /usr/local/bin/
```

### Install pip

```bash
sudo ln -fs $(which python3) /usr/bin/python

wget -O /tmp/get-pip.py https://bootstrap.pypa.io/get-pip.py
python /tmp/get-pip.py

sudo ln -fs $(which pip3) /usr/bin/pip
```

### Update tty login screen

```bash
[ ! -f /etc/issue.orig ] && sudo cp -v /etc/issue /etc/issue.orig
system_name="$(grep "^NAME" /etc/os-release | cut -d"=" -f2 | sed 's/"//g')"
system_version="$(cat /etc/debian_version)"
(
echo "[\l] ${system_name} ${system_version}"
echo ""
echo "hostname: \n"
echo "ethernet: \4{eth0}"
echo "wireless: \4{wlan0}"
echo ""
) | sudo tee /etc/issue
```

### Setup user home environment

```bash
echo "alias ll='ls -ahl'" >> ${HOME}/.bashrc
```

### Setup dashboard for pi user

You need to setup autologin into the terminal with a 'pi' user

```bash
wget -O /tmp/dashboard https://raw.githubusercontent.com/revgen/myenv/master/setup/linux/raspberry/dashboard
chmod +x /tmp/dashboard
sudo mv -v /tmp/dashboard /usr/local/bin/
```

```bash
(
    echo "# -- Run dashboard on the first terminal screen"
    echo "if tty | grep -q 'tty1'; then"
    echo "    dashboard"
    echo "fi"
) | sudo tee -a "/home/pi/.bashrc"
```

### Setup www home page

```bash
sudo chown master:users -R /var/www/html/
curl -L "https://assets.raspberrypi.com/favicon.png" > /var/www/html/favicon.png
wget -O /var/www/html/index.tmpl.html https://raw.githubusercontent.com/revgen/myenv/master/setup/linux/raspberry/index.tmpl.html
TITLE="$(hostname)" envsubst < /var/www/html/index.tmpl.html > /var/www/html/index.html
```

## KB

### Fix "bash: warning: setlocale: LC_ALL: cannot change locale"

```bash
sudo cp -v /etc/default/locale /etc/default/locale.$(date +%s)

echo "LANG=en_US.UTF-8
LC_ALL=en_US.UTF-8
LANGUAGE=en_US.UTF-8" | sudo tee /etc/default/locale
```
