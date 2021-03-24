#!/bin/sh
sudo find /usr/share/locale -mindepth 1 -maxdepth 1 -type d ! -name 'en' ! -name 'ru' -exec rm -vrf {} \;
