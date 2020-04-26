# pfSense

[**pfSense**](https://www.pfsense.org/) is a free and open source firewall 
and router that also features unified threat management, load balancing, multi WAN, and more.



## Enable last FreeBSD repository
```bash
cp -v /etc/pkg/FreeBSD.conf "/etc/pkg/FreeBSD.conf.`date +"%Y%m%d-%H%M%S"`.orig"
sed -i .bak 's/quarterly"/latest"/g' /etc/pkg/FreeBSD.conf
echo "FreeBSD: { enabled: yes }" > /usr/local/etc/pkg/repos/FreeBSD.conf
# enable free bsd repo in pfsence (change no to yes)
vi /usr/local/etc/pkg/repos/pfSense.conf

# Update the available remote repositories
pkg update
pkg -vv
```

## Default **bash** settings
```bash
echo 'export PS1="\u@\h:\W\$ "' >> ~/.bashrc
echo "alias ll='ls -ahl'" >> ~/.bashrc
echo "alias mc='/usr/local/bin/mc -u'" >> ~/.bashrc
```

## Tools from repository
```bash
pkg install bash wget jq yq git
pkg install mc screen htop ncdu vim-console
pkg install libxslt libxml2

pkg install python37
pkg install py37-pip
ln -s $(ls /usr/local/bin/python3.* | head -n 1) /usr/local/bin/python3
[ ! -f "/usr/local/bin/pip3" ] && ln -s $(ls /usr/local/bin/pip-3.* | head -n 1) /usr/local/bin/pip3
[ ! -f "/usr/local/bin/pip" ] && ln -s /usr/local/bin/pip3 /usr/local/bin/pip

pip3 install xq xmljson
```

## Custom scripts and tools
```bash
# create temp dir and download all scripts into it
cd $(mktemp -d) && cd $_
wget -O ./lsblk lsblk https://raw.githubusercontent.com/vermaden/scripts/master/lsblk.sh
wget -O ./inxi https://raw.githubusercontent.com/smxi/inxi/master/inxi

wget https://raw.githubusercontent.com/revgen/myenv/master/home/bin/localip
wget https://raw.githubusercontent.com/revgen/myenv/master/home/bin/externalip
wget https://raw.githubusercontent.com/revgen/myenv/master/home/bin/session
wget https://raw.githubusercontent.com/revgen/myenv/master/home/bin/sysinfo
wget https://raw.githubusercontent.com/revgen/myenv/master/home/bin/check-bad-domains
wget https://raw.githubusercontent.com/revgen/myenv/master/home/bin/check-internet-speed
wget https://raw.githubusercontent.com/revgen/myenv/master/home/bin/check-opendns
wget https://raw.githubusercontent.com/revgen/myenv/master/home/bin/dns-name-by-ip
wget https://raw.githubusercontent.com/revgen/myenv/master/home/bin/get-http-status-code
wget https://raw.githubusercontent.com/revgen/myenv/master/home/bin/xml-to-json

wget https://raw.githubusercontent.com/revgen/myenv/master/setup/freebsd/pfsence/usr/local/bin/notify-send
wget https://raw.githubusercontent.com/revgen/myenv/master/setup/freebsd/pfsence/usr/local/bin/view-squid-log
wget https://raw.githubusercontent.com/revgen/myenv/master/setup/freebsd/pfsence/usr/local/bin/pfhelper

# Change script attributes
chmod +x ./*

# Move all scripts to the local/bin
mv -v ./* /usr/local/bin
```

