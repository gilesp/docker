## -*- docker-image-name: "gilesp/eclipse" -*-
FROM ubuntu:18.04

MAINTAINER Giles Paterson <giles@vurt.uk>

LABEL name="gilesp/eclipse"
LABEL version="2018-12"

# Create dev user
RUN useradd -ms /bin/bash dev

# Install dependencies
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive \
    apt-get install -y \
    openjdk-11-jdk \
    && rm -rf /var/lib/apt/lists/*
    
# Have a variable for the tarball to ease maintenance.
ENV ECLIPSE_DOWNLOAD_URL https://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/2018-12/R/eclipse-jee-2018-12-R-linux-gtk-x86_64.tar.gz&r=1

# Install Eclipse
# Download and install Eclipse to have a local installation.
WORKDIR /opt
ADD ${ECLIPSE_DOWNLOAD_URL} /opt/eclipse.tar.gz
RUN tar -xvf eclipse.tar.gz && \
    rm -rf *.tar.gz

USER dev:dev
VOLUME /home/dev
WORKDIR /home/dev

ENTRYPOINT ["/opt/eclipse/eclipse"]
