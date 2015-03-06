#!/bin/sh
xhost +
docker run \
    --rm \
    -it \
    -v /home/giles/projects:/home/giles/projects \
    -v /home/giles/.config/MonoDevelop:/home/giles/.config/MonoDevelop \
    -v /home/giles/.config/MonoDevelop-5.0:/home/giles/.config/MonoDevelop-5.0 \
    -v /home/giles/.config/NuGet:/home/giles/.config/NuGet \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e DISPLAY=$DISPLAY \
    -p 9999:8080 \
    --name monodevelop \
    gilesp/monodevelop \
    /sbin/my_init \
    --skip-startup-files \
    --quiet \
    -- /sbin/setuser giles monodevelop
xhost -
