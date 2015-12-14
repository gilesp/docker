## -*- docker-image-name: "swift" -*-

# Docker image for developing with Swift on Linux

FROM ubuntu:15.10

MAINTAINER Giles Paterson <giles@vurt.uk>

LABEL version="1.0.0"

# Setup environment variables
ENV PATH $PATH:node_modules/.bin

##
## Install packages
##
RUN DEBIAN_FRONTEND=noninteractive apt-get update -q && \
	apt-get install -qy --no-install-recommends sudo gnupg clang libicu-dev libpython2.7

##
## Install Swift
##
# Set correct environment variables.
ENV SWIFT_VERSION swift-2.2-SNAPSHOT-2015-12-01-b-ubuntu15.10
ENV SWIFT_URL https://swift.org/builds/ubuntu1510/swift-2.2-SNAPSHOT-2015-12-01-b/
ENV SWIFT_SNAPSHOT $SWIFT_VERSION.tar.gz
ENV SWIFT_SIG $SWIFT_VERSION.tar.gz.sig

ADD $SWIFT_URL$SWIFT_SNAPSHOT /usr/local/
ADD $SWIFT_URL$SWIFT_SIG /usr/local/
RUN cd /usr/local && \
    gpg --keyserver hkp://pool.sks-keyservers.net \
    --recv-keys \
    '7463 A81A 4B2E EA1B 551F FBCF D441 C977 412B 37AD' \
    '1BE1 E29A 084C B305 F397 D62A 9F59 7F4D 21A5 6D5F' && \
    gpg --verify $SWIFT_SIG && \
    tar xzf $SWIFT_SNAPSHOT && \
    cp -R $SWIFT_VERSION/usr/* /usr/local/ && \
    rm -rf $SWIFT_VERSION*

##
## Create dev user
## This avoids permissions issues when running locally
##
ENV USERNAME dev

RUN adduser --disabled-password --gecos '' $USERNAME && \
    echo $USERNAME:$USERNAME | chpasswd && \
    echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    adduser $USERNAME sudo

# Add Tini
ENV TINI_VERSION v0.6.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

USER $USERNAME

# Set workdir
# You'll need to run this image with a volume mapped to /home/dev (i.e. -v $(pwd):/home/dev) or override this value
WORKDIR /home/$USERNAME/app

# Add swift to the PATH 
ENV PATH /usr/local/usr/bin:$PATH

ENTRYPOINT ["/tini", "--"]

# Run your program under Tini
# CMD ["/your/program", "-and", "-its", "arguments"]
# or docker run your-image /your/program ...
