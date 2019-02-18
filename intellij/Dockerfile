## -*- docker-image-name: "gilesp/intellij" -*-
FROM ubuntu:18.04

# Set maintainer information
MAINTAINER Giles Paterson <giles@vurt.uk>

LABEL name="gilesp/intellij"
LABEL version=2018.3.4

# Create dev user
RUN useradd -ms /bin/bash dev

# Install dependencies
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive \
    apt-get install -y \
    openjdk-11-jdk \
    && rm -rf /var/lib/apt/lists/*

# Install android studio
WORKDIR /opt
ADD https://download.jetbrains.com/idea/ideaIC-2018.3.4-no-jdk.tar.gz  idea.tar.gz 
RUN tar -xf idea.tar.gz && \
    rm -rf *.tar.gz

USER dev:dev
VOLUME /home/dev
WORKDIR /home/dev

ENTRYPOINT ["/opt/idea-IC-183.5429.30/bin/idea.sh"]
