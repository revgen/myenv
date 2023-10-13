#!/usr/bin/env bash
title() {
  echo "------------------------------------------------------------"
  echo "$@"
  echo ""
}

install_pip() {
    if which pip 2>&1 /dev/null; then
        echo "Pip already exists. Skip"
    else
        wget -O /tmp/get-pip.py https://bootstrap.pypa.io/get-pip.py
        sudo ln -fs $(which python3) /usr/bin/python
        python /tmp/get-pip.py
    fi
    sudo ln -fs $(which pip3) /usr/bin/pip
}

install_core_tools() {
    sudo apt update
    sudo apt install -y wget curl mc htop jq screen tree elinks dialog

    wget -O /tmp/session https://raw.githubusercontent.com/revgen/myenv/master/home/.local/bin/session
    chmod +x /tmp/session
    sudo mv -v /tmp/session /usr/local/bin/
    wget -O /tmp/sysinfo https://raw.githubusercontent.com/revgen/myenv/master/home/.local/bin/sysinfo
    chmod +x /tmp/sysinfo
    sudo mv -v /tmp/sysinfo /usr/local/bin/
}

make_setup_for_user() {
    echo "alias ll='ls -ahl'" >> ${HOME}/.bashrc
    # TODO: need to ask and check previous installation
    (
        echo "alias ll='ls -ahl'"
        echo "# -- Run dashboard on the first terminal screen"
        echo "if tty | grep -q 'tty1'; then"
        echo "    dashboard"
        echo "fi"
     ) >> ~/.bashrc
}

update_tty_login_screen() {
  [ ! -f /etc/issue.orig ] && sudo cp -v /etc/issue /etc/issue.orig
  system_name="$(grep "Name" /etc/os-release)"
  system_version="$(cat /etc/debian_version)"
  (
    echo "[\l] ${system_name} ${system_version}"
    echo ""
    echo "hostname: \n"
    echo "ethernet: \4{eth0}"
    echo "wireless: \4{wlan0}"
    echo ""
  ) | sudo tee /etc/issue
}

title "Setup my Raspberry PI"
install_core_tools
install_pip
make_setup_for_user
update_tty_login_screen

