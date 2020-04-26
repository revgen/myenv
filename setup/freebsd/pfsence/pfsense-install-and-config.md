# Installation and Configuration of pfSense

* [Installation](#installation)
* [Basic setup](#basic-setup)
* [Networks](#networks)
* [DNS](#dns)
* [Notifications](#notifications)
* [Dashboard](#dashboard)
* [Backup/Restore](#backup-restore)


## Installation

1. Download pfsense: https://pfsense.com (Old versions: http://linorg.usp.br/pfsense/downloads/)
    - Write it to the USB drive:
    - Install system from the USB drieve
2. Settings in terminal:
    - VLAN enabled: NO
    - WAN -> re0
    - LAN -> re1
3. **IMPORTANT:** Don't make any changes in the terminal at the begining


## Basic setup
1. Connect to the server using browser http://192.168.1.1
    admin / pfsense
2. **IMPORTANT:** Don't use wizard

3. Update password for Admin account
    - System -> User Management -> Edit: Admin
4. System -> Advanced
    - Protocol: http
    - Port: 80
    - Disable webConfigurator redirect rule: Yes
    - Enable Secure Shell: Yes
    - Console menu: protect with password
5. Reboot
    - Diagnostics -> Reboot
6. Reconnect to the web interface using http://192.168.1.1
7. Check Internet
8. System -> Cert. Manager
    - generate one self-signed sertificate


## Networks
1. Update IP address
    - Interfaces -> LAN
        - 192.168.10.1 / 24
        - Save. **DO NOT Apply!!!**
    - Services -> DHCP Server
        - Range: 192.168.10.101 - 192.168.10.200
    - Interface -> LAN
        - Apply changes
2. Reboot
3. Reconnect your ethernet cable or reset dhcp client, to update ip address on the client PC
4. Reconnect to the web intercafe using http://192.168.10.1

    
## DNS
1. System -> General
    - Hostname: gateway
    - Domain: local.lan
    - DNS Servers: 208.67.222.222, 208.67.220.220
    - Override DNS: NO
    - Timezone: America/New_York
2. Services -> DNS Resolver
    - Enable DNS resolver: Yes
    - Enable DNSSEC Support: No
    - Enable Forwarding Mode: Yes
    - Register DHCP leases in the DNS Resolver: Yes
    - Register DHCP static mappings in the DNS Resolver: Yes
3. Redirecting all DNS Requests to pfSense ([original doc](https://docs.netgate.com/pfsense/en/latest/dns/redirecting-all-dns-requests-to-pfsense.html))
    - Navigate to Firewall > NAT, Port Forward tab
    - Click **Add (up)** to create a new rule
    - Fill in the following fields on the port forward rule:
        - Interface: LAN
        - Protocol: TCP/UDP
        - Destination: Invert Match checked, LAN Address
        - Destination Port Range: 53 (DNS)
        - Redirect Target IP: 127.0.0.1
        - Redirect Target Port: 53 (DNS)
        - Description: Redirect DNS
        - NAT Reflection: Disable


## Notifications
1 System -> Advanced -> Notification
    - E-Mail server: smtp.gmail.com
    - E-Mail port: 465
    - Enable SMTP over SSL/TLS: Yes
    - Validate the SSL/TLS certificate presented by the server: Yes
    - From: <email>
    - Notification to: <your email address>
    - Auth: Username: <email>
    - Auth: Password: ******
    - Auth: Mechanism: Login


## Dashboard
2.2. System -> General
    - Hostname in Menu: Fully Domain Name
    - Dashboard columns: 3
    - Login page color: Dark gray
    - Login hostname: check (show hostname on login page)
2.3. System -> Dashboard
    - Add: Traffic Graph
    - Add: Service Statuses
    - Add: Firewall logs


## Backup/Restore

> It is very important to make backups for all you steps in setup process.
> **pfSense** automatically create backup for each changes in the
> configuration.

You can find Backup/Restore functionality on: ```Diagnostics``` -> ```Backup & Restore```

