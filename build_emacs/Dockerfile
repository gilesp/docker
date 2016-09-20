FROM debian:jessie-backports

MAINTAINER Giles Paterson <giles@vurt.uk>

RUN echo "deb-src http://ftp.uk.debian.org/debian/ jessie-backports main non-free contrib" >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -qy --no-install-recommends build-essential checkinstall libwebkitgtk-3.0-dev && \
    apt-get build-dep -qy emacs24 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
