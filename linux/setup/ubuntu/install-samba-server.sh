#!/usr/bin/env bash
echo "--[Begin: $(basename "${0}")]-----------------"

echo "Installing samba server..."
sudo apt-get install samba || exit 1

[ ! -e "/etc/samba/smb.conf.orig" ] && echo "Save original smb.conf" && \
    sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.orig

echo "Create shared directory"
sudo mkdir /home/shared
sudo chown nobody:users -R /home/shared
sudo chmod 0775 -R /home/shared
sudo mkdir -p /home/shared/{public,upload}
sudo chmod 0555 /home/shared/public
sudo chmod 0777 /home/shared/upload

echo "Create new /etc/samba/smb.conf"
grep -v -E "^#|^;" /etc/samba/smb.conf.orig | grep . > /tmp/smb.conf && \
echo -e "
[Public]
    comment = Readonly share content
    path = /home/shared/public
    browseable = yes
    guest ok = yes
    writable = no
[Upload]
    comment = Full access share
    path = /home/shared/upload
    browseable = yes
    guest ok = yes
    writable = yes
" >> /tmp/smb.conf && \
sudo mv /tmp/smb.conf /etc/samba/smb.conf && \
sudo chmod 655 /etc/samba/smb.conf && \
sudo chown root:root /etc/samba/smb.conf && \
\
echo "Restart service" && \
sudo systemctl restart smbd && \
sudo systemctl status smbd

echo "--[End: $(basename "${0}")  ]-----------------"
