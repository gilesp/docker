## -*- docker-image-name: "gilesp/androidstudio" -*-
FROM ubuntu:18.04

# Set maintainer information
MAINTAINER Giles Paterson <giles@vurt.uk>

LABEL name="gilesp/androidstudio"
LABEL version=3.3.1

# Create dev user
RUN useradd -ms /bin/bash dev

# Install dependencies
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive \
    apt-get install -y \
    libpulse0 \
    qemu-kvm \
    libvirt-bin \
    wget \
    unzip \
    openjdk-11-jdk \
    && rm -rf /var/lib/apt/lists/*

# Install android studio
WORKDIR /opt
RUN wget https://dl.google.com/dl/android/studio/ide-zips/3.3.1.0/android-studio-ide-182.5264788-linux.zip -O /tmp/android-studio.zip && \
    unzip /tmp/android-studio.zip 

USER dev:dev
VOLUME /home/dev
WORKDIR /home/dev

ENTRYPOINT ["/opt/android-studio/bin/studio.sh"]
