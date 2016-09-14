#!/bin/sh

docker run \
       --rm \
       --net=host \
       -e DISPLAY=$DISPLAY \
       -v ~/.Xauthority:/root/.Xauthority \
       -v /tmp/.X11-unix:/tmp/.X11-unix \
       gilesp/wine \
       /opt/wine-devel/bin/wine "$@"
