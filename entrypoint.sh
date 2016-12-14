#!/bin/sh
set -e

if [ ! -f /app/JDownloader.jar ]; then
    cp -R /tmp/jd2/* /app/
fi

userdel jd2 2>&1 1>/dev/null || true
groupdel jd2 2>&1 1>/dev/null || true
groupadd -g $GROUP_ID -o jd2 || (echo group jd2 already exists && exit 1)
useradd --shell /bin/bash -u $USER_ID -g jd2 -o -M -d /app jd2 || (echo user jd2 already exists && exit 1)

export DISPLAY=:99
killall Xvfb
rm -f /tmp/.X99-lock
nohup Xvfb $DISPLAY -screen 0 ${WIDTH}x${HEIGHT}x16 &

chown -R jd2:jd2 /app
cd /app

exec /usr/local/bin/gosu jd2 nohup x11vnc -loop -nevershared -display $DISPLAY -passwd "$PASSWORD" -forever -http &
exec /usr/local/bin/gosu jd2 nohup matchbox-window-manager -display $DISPLAY -use_titlebar yes &

exec /usr/local/bin/gosu jd2 "$@"

while [ ! -z "$(pgrep java)" ]; do
    sleep 10
done
