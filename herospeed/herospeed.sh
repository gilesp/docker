#!/bin/bash

WORKDIR=`pwd`

xhost +si:localuser:$(whoami) >/dev/null
docker run \
    --privileged \
    --rm \
    -ti \
    -e DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
    -v $WORKDIR/wine:/home/docker/wine/ \
    -v /etc/localtime:/etc/localtime:ro \
    -u docker \
    herospeed /bin/bash -c "sudo initialize-graphics >/dev/null 2>/dev/null; vglrun /home/docker/templates/herospeed.template"
