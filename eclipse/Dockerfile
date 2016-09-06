# Docker image for Eclipse IDE
FROM ubuntu:16.04

MAINTAINER Giles Paterson <giles@vurt.uk>

LABEL version="MARS.1"

# Install Oracle Java 8
RUN sed 's/main$/main universe/' -i /etc/apt/sources.list && \
    apt-get update && apt-get install -y software-properties-common && \
    add-apt-repository ppa:webupd8team/java -y && \
    apt-get update && \
    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    apt-get install -y oracle-java8-installer oracle-java8-unlimited-jce-policy oracle-java8-set-default

# Install additional packages & cleanup
RUN apt-get install -y libxext-dev libxrender-dev libxtst-dev libgtk2.0-0 libcanberra-gtk-module && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* && \
    rm -rf /var/tmp/*
    
# Have a variable for the tarball to ease maintenance.
ENV ECLIPSE_TARBALL eclipse-jee-mars-1-linux-gtk-x86_64.tar.gz
ENV ECLIPSE_DOWNLOAD_URL https://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/mars/1/${ECLIPSE_TARBALL}&r=1

# Install Eclipse
# Download and install Eclipse to have a local installation.
WORKDIR /opt
ADD ${ECLIPSE_DOWNLOAD_URL} /opt/${ECLIPSE_TARBALL}
RUN tar -xf ${ECLIPSE_TARBALL} && \
    rm -rf *.tar.gz
ADD eclipse.ini /opt/eclipse/eclipse.ini

# Install plugins we want
RUN /opt/eclipse/eclipse \
    -nosplash \
    -application org.eclipse.equinox.p2.director \
    -repository http://download.eclipse.org/releases/mars,http://download.eclipse.org/eclipse/updates/4.5,http://download.eclipse.org/webtools/repository/mars,http://eclipse-color-theme.github.com/update,https://dl.google.com/eclipse/plugin/4.5 \
    -destination /opt/eclipse \
    -installIU com.github.eclipsecolortheme
    
#Create development user to avoid file permission issues
ENV USERNAME dev

RUN adduser --disabled-password --gecos '' $USERNAME && \
    echo $USERNAME:$USERNAME | chpasswd && \
    echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    adduser $USERNAME sudo

USER $USERNAME

ENV HOME /home/$USERNAME

# Set workdir
# You'll need to run this image with a volume mapped to /app (i.e. -v $(pwd):/app) or override this value
WORKDIR /home/$USERNAME/workspace

CMD ["/opt/eclipse/eclipse"]
