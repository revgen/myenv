# CentOS 7

* [Install CentOS 7](#install-centos7)
* [Install MATE Desktop on CentOS](#install-mate-desktop)
* [Install core tools](#install-core-tools)
    - [Console tools](#install-core-console-tools)
    - [GUI tools](#install-core-gui-tools)
    - [Chrome](#install-chrome)
    - [NodeJS 10+](#install-nodejs-10)
    - [Python 3.8](#install-python-38)
    - [Visual Studio Code](#install-visual-studio-code)
    - [Console tools](#install-core-tools)
* [Remove unused packages](#remove-unused-packages)
* [RPM packages](#rpm-packages)
    

## Install CentOS 7

1. Download CentOS-7-x86_64-Minimal.iso from https://buildlogs.centos.org/centos/7/isos/x86_64/
1. Install System to the disk
1. After the reboot you can [install X-Window](#install-mate-desktop) and [install additional tools](#install-core-tools)

## Install MATE Desktop
```bash
sudo yum install epel-release -y
sudo yum groupinstall -y "X Window System"
sudo yum groupinstall -y "MATE Desktop"
sudo yum install -y lightdm-settings
sudo systemctl set-default graphical.target
```

## Install core tools

### Install core console tools
```bash
sudo yum install -y mc htop screen git tig vim wget ncdu elinks ImageMagick p7zip
```

### Install core GUI tools
```bash
sudo yum install -y xclip gedit pinta
sudo yum install -y libreoffice
```

### Install Chrome

```bash
wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
sudo yum localinstall google-chrome-stable_current_x86_64.rpm 
```

### Install NodeJS 10+
```bash
curl -sL https://rpm.nodesource.com/setup_10.x | sudo bash -
sudo yum info nodejs
sudo yum install nodejs

# check installation
echo "node $(node --version), npm v$(npm --version)"
```

### Install Python 3.8
```bash
sudo yum install -y gcc openssl-devel bzip2-devel libffi-devel
rm -rf /tmp/src; mkdir /tmp/src; cd /tmp/src
wget https://www.python.org/ftp/python/3.8.1/Python-3.8.1.tgz
tar xzf Python-3.*.tgz
cd Python-3.*
./configure --enable-optimizations
# make altinstall
sudo make install
cd ~/
rm -rf /tmp/src/Python*

# Make python3.8 default for python3
sudo update-alternatives --install /usr/bin/python3 python3 $(which python3.8) 0
sudo update-alternatives --config python3

# Install pip for Python3.8 if needed
python3.8 -m pip install pip
# or create a symlink if needed
sudo update-alternatives --install /usr/bin/pip3 pip3 $(which pip3.8) 0

# check installation
echo "$(python3 --version), $(pip3 --version)"
```

### Install Visual Studio Code

1. Download Visual Studio Code rpm: https://code.visualstudio.com/download
1. Install rpm package: ```sudo yum localinstall code-*.rpm```


## Remove unused packages
```bash
sudo yum remove -y pluma xchat brasero
sudo yum remove -y firefox
sudo yum remove -y filezilla
sudo yum remove -y transmission*
sudo yum remove -y simple-scan
```

## RPM packages

### If you need to download specific RPM package withot a package manager:
* Epel epository: https://centos.pkgs.org/7/epel-x86_64/
* Node.js 10.x: https://rpm.nodesource.com/pub_10.x/el/7/x86_64/nodesource-release-el7-1.noarch.rpm
* Draw.io: https://github.com/jgraph/drawio-desktop/releases/
* Visual Studio Code: https://code.visualstudio.com/download
* Mattermost: https://github.com/mattermost/desktop/releases (AppImage)
* Postman: https://www.getpostman.com/downloads/

### Install RPM package
```bash
rpm -i package-file-name.rpm
rpm -i --nosignature --force  package-file-name.rpm
```

### Search installed rpm packages in the system
```bash
rpm -qa 'vim*' or rpm -qa 'node|npm'
```