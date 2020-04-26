# Squid proxy server on pfSense

## Install Squid proxy server

### Installation

From the UI:
1. System -> Package Manager -> Available Packages
2. Search ```squid``` and install it
```

From the terminal:
```bash
pkg install pfSense-pkg-squid
```

### Setup squid server

Open: ```Service``` -> ```Squid Server```

1. Local Cache:
    - Hard Disk Cache Size: 20000
    - Level 1 Directories: 256
    - Memory Cache Size: 1024
    - Maximum Object size in RAM: 4600
2. General:
    - Enable Squid Proxy: Yes
    - Keep Settings/Data: Yes
    - Interfaces: LAN
    - Resolve DNS IPv4 First: Yes
    - Disable ICMP: Yes
    - -------------------
    - Transparent HTTP Proxy: Yes
    - Bypass Proxy for Private: Yes
    - Bypass Proxy for These Destination IPs: put alias names here, **DO NOT USE A REALD DNS** here (see: https://forum.netgate.com/post/629086)
    - -------------------
    - HTTPS/SSL Interception: Yes
    - SSL/MITM Mode: Splice All
    - Interface: LAN
    - SSL Proxy Compatibility Mode: Modern
    - CA: select your self signed sertificate
    - -------------------
    - Enable Access Logging: Yes
    - Rotate: 7
    - -------------------
    - Visible Hostname: ```gateway.local.lan```
    - Admin email: ```cool-admin@test.com```
    - Suppress Squid Version: yes


## Install Lightsquid log viewer

### Installation

From the UI:
1. System -> Package Manager -> Available Packages
2. Search ```lightsquid``` and install it
```

From the terminal:
```bash
pkg install pfSense-pkg-lightsquid
```

On my pfSense setup I have a problem with perl and I need to install perl5:
```bash
# check: perl --version
# and install if you need it:
pkg install -f perl5
# check lightsquid setup:
cd /usr/local/www/lightsquid
./check-setup.pl
```

### Setup Lightsquid

1. Status -> Squid Proxy Report
    - Use SSL for Lightsquid: No
    - Update password
    - Skip URL: localhost|192.168.10.
    - Refresh scheduler: 10min
    - ```Save```
2. ```Refresh All```
3. Now you can open Lightsquid on http://gateway.local.lan:7445/


## Install squidGuard


### Installation

From the UI:
1. System -> Package Manager -> Available Packages
2. Search ```squidGuard``` and install it
```

From the terminal:
```bash
pkg install pfSense-pkg-squidGuard
```

### Setup squidGuard

Open: Service -> Squid Guard
1. General Settings
    - Enable GUI log: Yes
    - Enable log: Yes
    - Enable log rotation: Yes
    - Clean Advertising: Yes
    - Blacklist: Yes
    - Blacklist URL: http://www.shallalist.de/Downloads/shallalist.tar.gz
2. Blacklist
    - Download the list
3. Target categories
    - Add new
        - Name: gw_blacklist
        - Domain list: yahoo.com
        - Log: Yes
    - Add new:
        -Name: gw_whitelist
4. Common ACL
    - Target rules:
        - gw_blacklist: deny
        - gw_whitelist: whitelist
        - Other: ...
        - Default access: allow
        - Log: Yes


