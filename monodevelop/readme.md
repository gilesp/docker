# Docker container for Xamarin Monodevelop IDE

This container, based on phusion/baseimage, installs the Xamarin Monodevelop IDE and can be used for local (i.e. on the host, not in the container) development.


## Usage

There's a simple shell script in this repo (monodevelop.sh) that enacpsulates the following in an xhost command to allow remote connections to the current X desktop.

    docker run \
        --rm \
        -it \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -e DISPLAY=$DISPLAY \
        --name monodevelop \
        gilesp/monodevelop \
        /sbin/my_init \
        --skip-startup-files \
        --quiet -- monodevelop
