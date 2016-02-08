## -*- docker-image-name: "eclim" -*-

# Docker image for eclim, configured for emacs use

FROM ubuntu:15.10

MAINTAINER Giles Paterson <giles@vurt.uk>

LABEL version="1.0.0"

##
## Create dev user
## This avoids permissions issues when running locally
##
ENV USERNAME dev

RUN adduser --disabled-password --gecos '' ${USERNAME} && \
    echo ${USERNAME}:${USERNAME} | chpasswd && \
    echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    adduser ${USERNAME} sudo

# Install Java 8 and other dependencies
RUN apt-get update && \
    apt-get install -y openjdk-8-jdk ant maven xvfb build-essential wget

# Install eclipse
ENV ECLIPSE_URL http://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/mars/M1/
ENV ECLIPSE_VERSION eclipse-jee-mars-M1-linux-gtk-x86_64
RUN cd /usr/local && \
    wget -O ${ECLIPSE_VERSION}.tar.gz ${ECLIPSE_URL}${ECLIPSE_VERSION}.tar.gz && \
    tar xzf ${ECLIPSE_VERSION}.tar.gz

# Download eclim
ENV ECLIM_URL http://sourceforge.net/projects/eclim/files/eclim/2.5.0/eclim_2.5.0.jar/download

RUN cd /usr/local && \
    wget -O eclim_2.5.0.jar ${ECLIM_URL}

# Add Tini
ENV TINI_VERSION v0.8.4
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

# Ensure dev user can write to eclipse install
RUN chgrp -R ${USERNAME} /usr/local/eclipse

USER ${USERNAME}

# Install eclim as dev
RUN java -Dvim.skip=true -Declipse.home=/usr/local/eclipse -jar /usr/local/eclim_2.5.0.jar install

# Set workdir
# We'll tell eclimd that our eclipse workspace is in this location. You can map this to a volume
# (i.e. -v $(pwd):/home/dev/workspace) on the host OS when running this container.
WORKDIR /home/$USERNAME/workspace

# Add swift to the PATH 
ENV PATH /usr/local/usr/bin:$PATH

ENTRYPOINT ["/tini", "--"]

# Run your program under Tini
# CMD ["/your/program", "-and", "-its", "arguments"]
# or docker run your-image /your/program ...
#CMD ["/usr/bin/xvfb-run" "/usr/local/eclipse/eclimd" "-b"]
