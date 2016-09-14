FROM yantis/wine

MAINTAINER Giles Paterson <giles@vurt.uk>

ADD http://domar.com/download/CMS/herospeed6.zip /tmp/herospeed6.zip

RUN mkdir -p /opt/herospeed && \
    unzip /tmp/herospeed6.zip -d /opt/herospeed && \
    rm -rf /tmp/herospeed6.zip

ADD herospeed.template /home/docker/templates/herospeed.template

USER docker
