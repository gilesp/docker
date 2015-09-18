#!/bin/sh
docker run --rm -it --privileged -v /dev/bus/usb:/dev/bus/usb -v $(pwd):/app react-native react-native "$@"
