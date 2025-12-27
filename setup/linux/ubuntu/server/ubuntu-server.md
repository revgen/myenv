# Ubuntu server setup

* [Setup core tools](#setup-core-tools)
* [Setup python](#setup-python)
* [Install nginx](#install-nginx)
* [Install docker](#install-docker)
* [Install system monitor](#install-system-monitor)
* [Setup XRDP](#setup-xrdp)
* [Add user](#add-user)
* [Setup rc.local](#setup-rc-local)
* [Setup SSH server](#setup-ssh-server)
* [Setup firewall](#setup-firewall)
* [Setup nextcloud](./setup-nextcloud.md)
* [Setup media server](./setup-media-server.md)

## Install core tools

```bash
sudo apt-add-repository multiverse && sudo apt-get update

# Remove vim and install neovim or vim-tiny
sudo apt purge -y vim vim-common vim-runtime 
sudo apt -y install neovim
# sudo apt -y install vim-tiny;

sudo cp -v /etc/bash.bashrc /etc/bash.bashrc.$(date +%s).bak
(echo ""; echo "export EDITOR=vi"; echo "") | sudo tee -a /etc/bash.bashrc
```

```bash
sudo apt -y install screen mc htop git curl wget lynx tree ncdu telnet
sudo apt -y install telnet iputils-ping net-tools dnsutils

sudo apt -y install jq
sudo add-apt-repository ppa:rmescandon/yq; sudo apt install yq -y

sudo apt -y install p7zip-full
sudo apt -y install figlet dialog

sudo apt -y intall ufw
sudo ufw allow 22
sudo ufw allow 80
sudo ufw allow 443
sudo ufw enable
sudo ufw status
```

```bash
sudo apt -y install duf
sudo apt -y install inxi --no-install-recommends
sudo apt -y install elinks
```

```bash
wget https://raw.githubusercontent.com/revgen/myenv/master/home/.local/bin/session
chmod +x session; sudo mv -v session /usr/local/bin/

wget https://raw.githubusercontent.com/revgen/myenv/master/home/.local/bin/sysinfo
chmod +x sysinfo; sudo mv -v sysinfo /usr/local/bin/

wget https://raw.githubusercontent.com/revgen/myenv/master/home/.local/bin/localip
chmod +x localip; sudo mv -v localip /usr/local/bin/

wget https://raw.githubusercontent.com/revgen/myenv/master/home/.local/bin/externalip
chmod +x externalip; sudo mv -v externalip /usr/local/bin/

wget https://raw.githubusercontent.com/revgen/myenv/master/tools/telebot
chmod +x telebot; sudo mv -v telebot /usr/local/bin/

wget https://raw.githubusercontent.com/revgen/myenv/master/tools/ddclient
chmod +x ddclient; sudo mv -v ddclient /usr/local/bin/

wget https://raw.githubusercontent.com/revgen/myenv/master/tools/gitlab
chmod +x gitlab; sudo mv -v gitlab /usr/local/bin/
```

### Remove snap

```bash
sudo apt autoremove -y --purge snapd lxd
```

## Setup python

```bash
which python3 >/dev/null || sudo apt -y install python3
which pip3 >/dev/null || sudo apt -y install python3-pip

sudo apt -y install python3-venv
[ -z "$(which python)" ] && sudo ln -fvs $(which python3) /usr/bin/python
[ -z "$(which pip)" ] && sudo ln -fvs $(which pip3) /usr/bin/pip
```

```bash
# Install python packages
pip3 install pip
python3 -m pip install requests fastapi python-dotenv --break-system-packages
```

## Install nginx

```bash
sudo apt -y install nginx

sudo chown -R ${USER}:users -R /var/www/html/
```

## Install docker

```bash
sudo apt -y install docker.io
sudo systemctl start docker
sudo systemctl enable docker

sudo usermod -aG docker ${USER}

sudo apt install -y docker-compose-v2
```

## Install system monitor

```bash
sudo python3 -m pip install bottle glances fastapi ujson --break-system-packages
wget https://raw.githubusercontent.com/revgen/myenv/master/setup/linux/ubuntu/install-system-monitor-glances.sh
sudo bash install-system-monitor-glances.sh

sudo ufw allow 61208
```

## Install xrdp

```bash
wget https://raw.githubusercontent.com/revgen/myenv/master/setup/linux/ubuntu/install-xrdp-with-xfce.sh
sudo sh install-xrdp-with-xfce.sh
```

## Add user

```bash
new_user="john"
sudo adduser --home "/home/${new_user}" --shell /bin/bash --quiet --disabled-password \
    --gecos "${new_user}" "${new_user}" || return 1
new_pass="$(head -c 32 /dev/random  | base64 | head -c 32)"
# echo "Generated password: ${new_pass}"
echo "${new_user}:${new_pass}" | sudo chpasswd

# If we need an generated avatar
user_letter="$(echo "${new_user}" | tr [:lower:] [:upper:] | head -c 1)"
wget -O /tmp/.face "https://placehold.co/96x96/283C50/FFFFFF/png?text=${user_letter}"
sudo mv -v /tmp/.face "/home/${new_user}/.face"
sudo chown -v "${new_user}:${new_user}" "/home/${new_user}/.face"
sudo chmod -v 0640 "/home/${new_user}/.face"
```

## Setup rc.local

```bash
    if [ -f /etc/systemd/system/rc-local.service ] && [ -f /etc/rc.local ]; then
        echo "Looks like rc.local already setup. Skip"
    else
        if [ ! -f /etc/rc.local ]; then
            (
                echo '#!/bin/bash'
                echo 'logger -st "rc.local" "Start execution at $(date +%FT%T%z)"'
                echo ""
                echo "# put your custom code here"
                echo ""
                echo 'logger -st "rc.local" "Stop execution at $(date +%FT%T%z)"'
                echo 'exit 0'
            ) | sudo tee /etc/rc.local
        fi
        sudo chmod +x /etc/rc.local
        if [ ! -f /etc/systemd/system/rc-local.service ]; then
            (
                echo "[Unit]"
                echo "  Description=/etc/rc.local Compatibility"
                echo "  ConditionPathExists=/etc/rc.local"
                echo ""
                echo "[Service]"
                echo "  Type=forking"
                echo "  ExecStart=/etc/rc.local start"
                echo "  TimeoutSec=0"
                echo "  StandardOutput=tty"
                echo "  RemainAfterExit=yes"
                echo "  SysVStartPriority=99"
                echo ""
                echo "[Install]"
                echo "  WantedBy=multi-user.target"
            ) | sudo tee /etc/systemd/system/rc-local.service
        fi
        sudo chown root:root /etc/systemd/system/rc-local.service
        sudo systemctl enable rc-local
        sudo systemctl start rc-local
        sudo systemctl status rc-local
    fi
```
## Setup SSH server

```bash
test -e /usr/sbin/sshd || sudo apt-get install openssh-server
```

```bash
# SSH Server settings:
# sudo vim /etc/ssh/sshd_config
# Add:
#    PermitRootLogin no
# Add:
#    AllowUsers master dev bob
# sudo systemctl restart ssh
```

> TODO: 2FA....

## Optional: Setup firewall (ufw)

```bash
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https
sudo ufw allow out 53,113,123/udp
# -- dev ports --
# sudo ufw allow 8000:8999/tcp

sudo ufw enable
sudo ufw status
```
## Optional: Setup firewall (iptables)

```bash
sudo iptables -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT
sudo iptables -A INPUT -p tcp -m tcp --dport 443 -j ACCEPT
sudo iptables -A INPUT -p tcp -m tcp --dport 8000:8099 -j ACCEPT
# iptable's changes is working immediately

```

## Optional: Setup firewall (firewalld)

```bash
sudo apt install -y firewalld
sudo firewall-cmd --zone=public --permanent --add-port=80/tcp
sudo firewall-cmd --zone=public --permanent --add-port=443/tcp
sudo firewall-cmd --zone=public --permanent --add-port=8080-8099/tcp
sudo firewall-cmd --reload
sudo firewall-cmd --state
sudo firewall-cmd --list-all
# sudo firewall-cmd --zone=public --list-all
# sudo firewall-cmd --zone=public --list-ports
```
