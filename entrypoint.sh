#!/bin/bash
cd /home/container

file=/etc/supervisor/conf.d/supervisord.conf
vncport=5902
webport=8181

OLD="command=/usr/bin/x11vnc -noxrecord -rfbport %%vncport%%"
NEW="command=/usr/bin/x11vnc -noxrecord -rfbport ${vncport}"
sudo sed -i "s|$OLD|$NEW|g" $file

OLD="command=/root/novnc/utils/launch.sh --vnc localhost:%%vncport%% --listen %%webport%%"
NEW="command=/root/novnc/utils/launch.sh --vnc localhost:${vncport} --listen ${webport}"
sudo sed -i "s|$OLD|$NEW|g" $file

MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
echo ":/home/container$ ${MODIFIED_STARTUP}"

#OLD="command=/opt/wine-stable/bin/wine /opt/wine-stable/lib/wine/explorer.exe"
#NEW="command=/opt/wine-stable/bin/wine ${MODIFIED_STARTUP}"
#sudo sed -i "s|$OLD|$NEW|g" $file
sudo /usr/bin/supervisord

