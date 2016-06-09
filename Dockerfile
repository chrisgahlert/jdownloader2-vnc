FROM ubuntu:14.04.4

MAINTAINER chrisgahlert

ENV WIDTH=1280
ENV HEIGHT=768

ENV USER_ID=0
ENV GROUP_ID=0

ENV PASSWORD=jd2

ENV GOSU_VERSION 1.7
RUN set -x \
    && apt-get update && apt-get install -y --no-install-recommends ca-certificates wget && rm -rf /var/lib/apt/lists/* \
    && wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
    && wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" \
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
    && rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu \
    && gosu nobody true \
    && apt-get purge -y --auto-remove ca-certificates wget

RUN apt-get update && apt-get upgrade -y && apt-get install -y openjdk-7-jre x11vnc Xvfb matchbox-window-manager

COPY JDownloader.jar /tmp/jd2/
RUN java -jar /tmp/jd2/JDownloader.jar -norestart

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["java", "-jar", "/app/JDownloader.jar"]
VOLUME ["/app", "/download"]
EXPOSE 5800 5900
