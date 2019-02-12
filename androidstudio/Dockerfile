FROM ubuntu:18.04

MAINTAINER Giles Paterson <giles@vurt.uk>

LABEL name="gilesp/androidstudio" version=0.0.1

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && \
        apt-get install -y libpulse0 wget unzip openjdk-11-jdk && \
        rm -rf /var/lib/apt/lists/*

WORKDIR /opt
RUN wget https://dl.google.com/dl/android/studio/ide-zips/3.3.1.0/android-studio-ide-182.5264788-linux.zip -O /tmp/android-studio.zip && \
        unzip /tmp/android-studio.zip 

CMD ["/opt/android-studio/bin/studio.sh"]
