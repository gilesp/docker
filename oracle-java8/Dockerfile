# Docker image for the Oracle Java 8 SDK
FROM phusion/baseimage:0.9.18

MAINTAINER Giles Paterson <giles@vurt.uk>

# Set correct environment variables.
ENV HOME /root

# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

# Install Oracle Java
RUN DEBIAN_FRONTEND=noninteractive apt-get -qy --no-install-recommends install software-properties-common && \
    add-apt-repository ppa:webupd8team/java && \
    apt-get update && \
    echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections && \
    apt-get -qy --no-install-recommends install oracle-java8-installer oracle-java8-unlimited-jce-policy oracle-java8-set-default 

# Clean up APT when done.
RUN DEBIAN_FRONTEND=noninteractive apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
