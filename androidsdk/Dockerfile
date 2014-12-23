# Docker image to host android sdk tools

FROM gilesp/oracle-java8

MAINTAINER Giles Paterson <giles@vurt.uk>

# Set correct environment variables.
ENV ANDROID_SDK_FILE android-sdk_r24.0.1-linux.tgz
ENV ANDROID_SDK_URL http://dl.google.com/android/$ANDROID_SDK_FILE

# Install 32bit support for Android SDK
RUN dpkg --add-architecture i386
RUN apt-get update
RUN apt-get -y install libc6:i386 libncurses5:i386 libstdc++6:i386 zlib1g:i386 lib32z1 lib32ncurses5 lib32bz2-1.0 g++-multilib

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
RUN echo "y" | android update sdk --no-ui --force --filter platform-tools,android-21,build-tools-21.1.2

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
