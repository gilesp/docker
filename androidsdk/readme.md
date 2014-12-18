# Docker container for the Android dev tools

This container, ultimately based on phusion/baseimage, installs the Android SDK and can be used for local (i.e. on the host, not in the container) development.
It builds on my oracle-jdk8 image, which provides the required Java tooling.


## Setup

    docker build -t gilesp/androidsdk .

Then create an shell alias as follows

    alias adk='docker run -i --privileged -v /dev/bus/usb:/dev/bus/usb gilesp/androidsdk'

The --privileged -v /dev/bus/usb:/dev/bus/usb allow the container to access the usb facilities of the host machine which you'll need if you want to deploy an app to an actual device.

## Usage

You can then use the java and android sdk tools by prefixing them with your alias:

    adk adb devices -l
