FROM ubuntu:14.04.4

MAINTAINER chrisgahlert

ENV WIDTH=1280
ENV HEIGHT=768

ENV USER_ID=99
ENV GROUP_ID=100

ENV PASSWORD=jd2


RUN apt-get update && apt-get upgrade -y && apt-get install -y openjdk-7-jre x11vnc Xvfb matchbox-window-manager

COPY JDownloader.jar /app/
RUN java -jar /app/JDownloader.jar -norestart

COPY start.sh /app
RUN chmod +x /app/start.sh

CMD ["/app/start.sh"]
VOLUME ["/app", "/download"]
EXPOSE 5800 5900
