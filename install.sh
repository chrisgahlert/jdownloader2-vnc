#!/bin/sh

export DISPLAY=:99

nohup Xvfb $DISPLAY -screen 0 ${WIDTH}x${HEIGHT}x16 &

exec java -jar /tmp/jd2/JDownloader.jar -n