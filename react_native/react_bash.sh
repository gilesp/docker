#!/bin/sh
docker run --rm -it --privileged -v /dev/bus/usb:/dev/bus/usb -v $(pwd):/app -p 8081:8081 react-native /bin/bash
