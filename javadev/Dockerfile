# Docker image for Java 8 Development
FROM gilesp/oracle-java8

MAINTAINER Giles Paterson <giles@vurt.uk>

# Have a variable for the tarball to ease maintenance.
ENV IDEA_TARBALL ideaIC-14.0.3.tar.gz
ENV FIREFOX_TARBALL firefox-28.0.tar.bz2
ENV FIREFOX_URL http://ftp.mozilla.org/pub/mozilla.org/firefox/releases/28.0/linux-x86_64/en-GB/${FIREFOX_TARBALL}

# Install Git & Maven3
RUN add-apt-repository ppa:andrei-pozolotin/maven3 && \
    apt-get update && \
    apt-get -y install git maven3 && \
    apt-get -y install libxext-dev libxrender-dev libxtst-dev

# Install IntelliJ
# Download and install Intellij IDEA to have a local installation.
WORKDIR /usr/local
ADD http://download.jetbrains.com/idea/${IDEA_TARBALL} /usr/local/
RUN tar -xf ${IDEA_TARBALL} && \
    rm -rf *.tar.gz && \
    mv idea* idea

# Install specific firefox version (for Selenium tests)
# This is only required when selenium lags behind firefox versions
# Ordinarily you could just do an apt-get install firefox
ADD ${FIREFOX_URL} /usr/local/
RUN tar -jxf ${FIREFOX_TARBALL} && \
    rm -rf *.tar.bz2
# Install firefox dependencies
RUN apt-get -y install $(apt-cache depends firefox | grep Depends | sed "s/.*ends:\ //" | tr '\n' ' ')

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Define mount point to access data on host system.
VOLUME ["/workspace"]
VOLUME ["/idea"]

#Create local user that matches one on host machine
RUN mkdir -p /home/giles && \
    echo "giles:x:1000:1000:Giles,,,:/home/giles:/bin/bash" >> /etc/passwd && \
    echo "giles:x:1000:" >> /etc/group && \
    echo "giles ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/giles && \
    chmod 0440 /etc/sudoers.d/giles && \
    chown giles:giles -R /home/giles

# Set workdir
# You'll need to run this image with a volume mapped to /app (i.e. -v $(pwd):/app) or override this value
WORKDIR /home/giles/workspace

# Expose xsp4 server port
EXPOSE 8080

# Add intellij binaries to path
ENV PATH $PATH:/usr/local/idea/bin:/usr/local/firefox

# Set up Intellij IDEA to add custom config and system path properties.
RUN sed -i 's/# idea.config.path=/idea.config.path=/g' /usr/local/idea/bin/idea.properties
RUN sed -i 's/# idea.system.path=/idea.system.path=/g' /usr/local/idea/bin/idea.properties

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
