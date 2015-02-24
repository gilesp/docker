#!/bin/sh
xhost +
docker run \
    --rm \
    -it \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e DISPLAY=$DISPLAY \
    --name monodevelop \
    gilesp/monodevelop \
    /sbin/my_init \
    --skip-startup-files \
    --quiet \
    -- monodevelop
xhost -
