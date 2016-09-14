FROM gilesp/wine

MAINTAINER Giles Paterson <giles@vurt.uk>

ADD http://domar.com/download/CMS/herospeed6.zip /tmp/herospeed6.zip

RUN apt-get update && \
    apt-get install -qy --no-install-recommends unzip && \
    apt-get clean && \
    mkdir -p /opt/herospeed && \
    unzip /tmp/herospeed6.zip -d /opt/herospeed && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER $USERNAME
