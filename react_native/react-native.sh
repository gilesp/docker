#!/bin/sh
docker run \
       --rm \
       -it \
       --privileged \
       -v /dev/bus/usb:/dev/bus/usb \
       -v $(pwd):/home/dev/app \
       react-native \
       react-native "$@"
