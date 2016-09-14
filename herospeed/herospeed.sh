#!/bin/bash

WORKDIR=`pwd`

docker run \
       --rm \
       --net=host \
       -e DISPLAY=$DISPLAY \
       -v ~/.Xauthority:/root/.Xauthority \
       -v /tmp/.X11-unix:/tmp/.X11-unix \
       -v $WORKDIR/.wine:/root/.wine \
       herospeed \
       /opt/wine-devel/bin/wine /opt/herospeed/CMS6.1.2.5.exe
