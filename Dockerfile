FROM ubuntu:14.04.4

MAINTAINER chrisgahlert

ENV WIDTH=1280
ENV HEIGHT=768

ENV USER_ID=99
ENV GROUP_ID=100

ENV PASSWORD=jd2


RUN apt-get update && apt-get upgrade -y && apt-get install -y openjdk-7-jre x11vnc Xvfb matchbox-window-manager

COPY JDownloader.jar /tmp/jd2/
RUN java -jar /tmp/jd2/JDownloader.jar -norestart

COPY start.sh /
RUN chmod +x /start.sh

CMD ["/start.sh"]
VOLUME ["/app", "/download"]
EXPOSE 5800 5900
