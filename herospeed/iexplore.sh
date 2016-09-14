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
       /opt/wine-devel/bin/wine "C:\Program Files\Internet Explorer\iexplore.exe"
