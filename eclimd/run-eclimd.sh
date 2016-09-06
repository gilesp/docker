#!/bin/sh
# script to launch eclimd

# Map current directory to workspace, and create a folder for eclipse
# to use to store plugins etc. Allowing for specific eclipse config
# per project.
ECLIPSE_PLUGINS_DIR=.eclipse-docker
WORKDIR=`pwd`

docker run \
       --rm \
       -it \
       -v $WORKDIR/$ECLIPSE_PLUGINS_DIR:/home/giles/.eclipse \
       -v $WORKDIR:/home/giles/projects \
       -p 9091:9091 \
       --name "eclimd" \
       gilesp/eclim \
       /usr/bin/xvfb-run /usr/local/eclipse/eclimd  "$@"
