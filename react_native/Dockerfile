## -*- docker-image-name: "react-native" -*-

# Docker image for react native experimentation

FROM node:4.0.0

MAINTAINER Giles Paterson <giles@vurt.uk>

# Setup environment variables
ENV PATH $PATH:node_modules/.bin

# Install react native
RUN npm install -g react-native-cli

# Clean up when done.
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    npm cache clear

# Set workdir
# You'll need to run this image with a volume mapped to /app (i.e. -v $(pwd):/app) or override this value
WORKDIR /app
