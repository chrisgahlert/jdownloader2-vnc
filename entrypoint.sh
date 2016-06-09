#!/bin/sh

if [ ! -f /app/JDownloader.jar ]; then
    cp -R /tmp/jd2/* /app/
fi

export DISPLAY=:0

nohup Xvfb $DISPLAY -screen 0 ${WIDTH}x${HEIGHT}x16 &
nohup x11vnc -loop -nevershared -display $DISPLAY -passwd "$PASSWORD" -forever -http &
nohup matchbox-window-manager -display $DISPLAY -use_titlebar yes &

chown -R $USER_ID:$GROUP_ID /app
exec /usr/local/bin/gosu $USER_ID:$GROUP_ID "$@"

while [ ! -z "$(pgrep java)" ]; do
    sleep 10
done
