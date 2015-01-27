# Docker container for the Cordova dev tools

This container, ultimately based on phusion/baseimage, installs Cordova and can be used for local (i.e. on the host, not in the container) development.
It builds on my androidsdk image, which provides the required Android SDK and Java tooling.


## Setup

    docker build -t gilesp/androidsdk .

Then create an shell alias as follows

    alias cdv='docker run --rm -t -i --privileged -v /dev/bus/usb:/dev/bus/usb -v $(pwd):/app -p 8001:8000 gilesp/cordova /sbin/my_init --skip-startup-files --quiet -- '

The --privileged -v /dev/bus/usb:/dev/bus/usb allow the container to access the usb facilities of the host machine which you'll need if you want to deploy an app to an actual device.

From docker 1.2, you should be able to create the alias as follows:

    alias cdv='docker run --rm -t -i --device=/dev/bus/usb/xxx/yyy:/dev/bus/usb/xxx/yyy -v $(pwd):/app -p 8001:8000 gilesp/cordova /sbin/my_init --skip-startup-files --quiet -- '

Which doesn't require privilige escalation. xxx/yyy are the usb ids of the device you want to deploy/test on. Find these with lsusb

The --rm is important as it tells docker to clean up the instances when the command finishes. Without that you'll end up with a stale instace (visible with docker ps -a) each time you run a command.

## Usage

You can then use the cordova tools by prefixing them with your alias:

    cdv cordova create hello com.example.hello HelloWorld

If you're going to running a lot of commands, it'd be work invoking a shell and then interacting with cordova there, rather than create many throw-away containers:

    cdv /bin/bash
