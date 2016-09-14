FROM debian:jessie-backports

MAINTAINER Giles Paterson <giles@vurt.uk>

ADD https://dl.winehq.org/wine-builds/Release.key /tmp/Release.key

RUN apt-key add /tmp/Release.key && \
    rm /tmp/Release.key && \
    echo "deb http://dl.winehq.org/wine-builds/debian/ jessie main" > /etc/apt/sources.list.d/winehq.list && \
    dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -qy --no-install-recommends winehq-devel && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
    
ENV DISPLAY :0
