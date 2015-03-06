# Docker container for Java development using IntelliJ IDEA

This container, based on phusion/baseimage, installs the IntelliJ Idea Community Edition IDE and can be used for local (i.e. on the host, not in the container) development.


## Usage

There's a simple shell script in this repo (javadev.sh) that enacpsulates the following in an xhost command to allow remote connections to the current X desktop.

    docker run \
        --rm \
        -it \
        ...
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -e DISPLAY=$DISPLAY \
        --name javadev \
        gilesp/javadev \
        /sbin/my_init \
        --skip-startup-files \
        --quiet \
        -- /sbin/setuser username idea.sh

In addition, the shellscript handles setting up volumes to share the code and IntelliJ config with the host in a controlled manner.
