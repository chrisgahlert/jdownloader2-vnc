#!/bin/sh

nohup Xvfb :0 -screen 0 ${WIDTH}x${HEIGHT}x16 &
nohup x11vnc -loop -nevershared -display :0 -passwd "$PASSWORD" -forever -http &
chown -R $USER_ID:$GROUP_ID /app
DISPLAY=:0 java -jar /app/JDownloader.jar
nohup matchbox-window-manager -display :0 -use_titlebar yes &

while [ ! -z "$(pgrep java)" ]; do
    sleep 10
done
