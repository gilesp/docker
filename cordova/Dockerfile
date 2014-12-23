# Docker image to host android sdk tools

FROM gilesp/androidsdk

MAINTAINER Giles Paterson <giles@vurt.uk>

# Install nodejs
RUN add-apt-repository -y ppa:chris-lea/node.js && \
    apt-get update -qq && \
    apt-get install -y nodejs

# Install and
RUN apt-get install -y ant

# Setup environment variables
ENV PATH $PATH:node_modules/.bin

# Ensure android-19 is installed as cordova only supports that
RUN echo "y" | android update sdk --no-ui --force --filter android-19

# Install nodejs
RUN npm install -g cordova

# Clean up when done.
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    npm cache clear

# Set workdir
# You'll need to run this image with a volume mapped to /app (i.e. -v $(pwd):/app) or override this value
WORKDIR /app