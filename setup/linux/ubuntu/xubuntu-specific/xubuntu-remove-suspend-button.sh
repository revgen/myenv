#!/bin/bash

CFG=/etc/xdg/xdg-xubuntu/xfce4/xfconf/xfce-perchannel-xml/xfce4-session.xml

newnode='
  <property name="shutdown" type="empty">
    <property name="ShowSuspend" type="bool" value="false"/>
    <property name="ShowHibernate" type="bool" value="false"/>
  </property>
</channel>
'
sudo cp ${CFG} ${CFG}.orig && \
cat ${CFG} | sed 's/<\/channel>//g' > xfce4-session.xml
echp -e '
  <property name="shutdown" type="empty">
    <property name="ShowSuspend" type="bool" value="false"/>
    <property name="ShowHibernate" type="bool" value="false"/>
    </property>
</channel>
' >> /tmp/xfce4-session.xml && \
sudo mv /tmp/xfce4-session.xml ${CFG} && \
sudo chmod 0644 ${CFG} && \
sudo chown root:root ${CFG}


