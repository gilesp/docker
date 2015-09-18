## -*- docker-image-name: "react-native" -*-

# Docker image for react native experimentation

FROM node:4.0.0

MAINTAINER Giles Paterson <giles@vurt.uk>

# Setup environment variables
ENV PATH $PATH:node_modules/.bin

##
## Install Java
##
RUN apt-get update && \
    apt-get -y install default-jdk

##
## Install Android SDK
##
# Set correct environment variables.
ENV ANDROID_SDK_FILE android-sdk_r24.0.1-linux.tgz
ENV ANDROID_SDK_URL http://dl.google.com/android/$ANDROID_SDK_FILE

# Install 32bit support for Android SDK
RUN dpkg --add-architecture i386
RUN apt-get update
RUN apt-get -y install libstdc++6:i386 libgcc1:i386 zlib1g:i386 libncurses5:i386

# Install Android SDK
RUN cd /usr/local && \
    wget $ANDROID_SDK_URL && \
    tar -xzf $ANDROID_SDK_FILE && \
    export ANDROID_HOME=/usr/local/android-sdk-linux && \
    export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools && \
    chgrp -R users /usr/local/android-sdk-linux && \
    chmod -R 0775 /usr/local/android-sdk-linux && \
    rm $ANDROID_SDK_FILE

# Setup environment variables for Android SDK
#RUN echo -e "export ANDROID_HOME=/usr/local/android-sdk-linux \nexport PATH=\$PATH:/usr/local/android-sdk-linux/tools:/usr/local/android-sdk-linux/platform-tools" >> /etc/profile.d/android.sh

# Install android tools and system-image.
ENV ANDROID_HOME /usr/local/android-sdk-linux
ENV PATH $PATH:$ANDROID_HOME/tools
ENV PATH $PATH:$ANDROID_HOME/platform-tools
RUN echo "y" | android update sdk --no-ui --force --all --filter platform-tools,android-23,build-tools-23.0.1,extra-android-support-23.0.1,extra-android-m2repository

##
## Install react native
##
RUN npm install -g react-native-cli

# Clean up when done.
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    npm cache clear

# Default react-native web server port
EXPOSE 8081

# Set workdir
# You'll need to run this image with a volume mapped to /app (i.e. -v $(pwd):/app) or override this value
WORKDIR /app

# Tell gradle to store dependencies in a sub directory of the android project
# this persists the dependencies between builds
ENV GRADLE_USER_HOME /app/android/gradle_deps
