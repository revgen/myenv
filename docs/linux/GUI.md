# Linux GUI: ubuntu based


## Install desktop GUI on the Ubuntu Server

### Full version desktops:
* Ubuntu Desktop Full: sudo apt-get install ubuntu-desktop
* Gnome 3: sudo apt-get install gnome-shell
* KDE: sudo apt-get install kubuntu-desktop
* XFCE: sudo apt-get install xubuntu-desktop
* LXDE: sudo apt-get install lubuntu-desktop
* Openbox: sudo apt-get install openbox
* Gnome Classic: sudo apt-get install gnome-session-fallback
* Ubuntu Gnome: sudo apt install ubuntu-gnome-desktop

### Ubuntu sstem only (without Email, OpenOffice and etc):
```bash
sudo apt-get install --no-install-recommends ubuntu-desktop
```

### Minimal GUI interface (openbox) with manuall launcher:
```bash
sudo apt install xorg
sudo apt install --no-install-recommends openbox
```

To start XWindows manually from the terminal:
```bash
startx
```

### Minimal GUI with display manager:
sudo apt install xorg
sudo apt install --no-install-recommends lightdm-gtk-greeter
sudo apt install --no-install-recommends lightdm
sudo apt install --no-install-recommends openbox

### Useful links

* AskUbuntu: [Ubuntu Server with a GUI](https://askubuntu.com/a/788193), [How do you run Ubuntu Server with a GUI?](https://askubuntu.com/questions/53822/how-do-you-run-ubuntu-server-with-a-gui)
* Openbox settings: [from archlinux.org](https://wiki.archlinux.org/index.php/openbox), [from r-darwish](https://github.com/r-darwish/openbox-config)
* []
