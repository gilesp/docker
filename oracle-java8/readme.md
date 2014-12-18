# Docker container for Oracle Java 8 SDK

This container, based on phusion/baseimage, installs the Oracle Java 8 SDK and can be used for local (i.e. on the host, not in the container) development.


## Setup

    docker build -t gilesp/oracle-java8 .

Then create an shell alias as follows

    alias jdk8='docker run -i gilesp/oracle-java8'

## Usage

You can then use the java sdk tools by prefixing them with your alias:

    jdk8 java -version

gives the output

    java version "1.8.0_25"
    Java(TM) SE Runtime Environment (build 1.8.0_25-b17)
    Java HotSpot(TM) 64-Bit Server VM (build 25.25-b02, mixed mode)
