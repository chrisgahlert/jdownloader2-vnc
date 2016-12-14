#!/bin/sh
set -e

if [ ! -f /app/JDownloader.jar ]; then
    cp -R /tmp/jd2/* /app/
fi

export DISPLAY=:99
killall Xvfb 2>&1 1>/dev/null || true
rm -f /tmp/.X99-lock
nohup Xvfb $DISPLAY -screen 0 ${WIDTH}x${HEIGHT}x16 &

chown -R $USER_ID:$GROUP_ID /app
cd /app

exec /usr/local/bin/gosu $USER_ID:$GROUP_ID nohup x11vnc -loop -nevershared -display $DISPLAY -passwd "$PASSWORD" -forever -http &
exec /usr/local/bin/gosu $USER_ID:$GROUP_ID nohup matchbox-window-manager -display $DISPLAY -use_titlebar yes &

exec /usr/local/bin/gosu $USER_ID:$GROUP_ID "$@"

while [ ! -z "$(pgrep java)" ]; do
    sleep 10
done
