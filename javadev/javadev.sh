#!/bin/sh
if [ "$#" -ne 1 ]; then
    echo "Please specify workspace name"
    exit 1
fi

PROJECT_DIR=/home/giles/projects
WORKSPACE_DIR=$PROJECT_DIR/$1/workspace
IDEA_SYS_DIR=$PROJECT_DIR/$1/idea_sys
IDEA_USR_DIR=$PROJECT_DIR/$1/.idea
if [ ! -d "$PROJECT_DIR/$1" ]; then
    mkdir $PROJECT_DIR/$1
fi
if [ ! -d "$WORKSPACE_DIR" ]; then
    mkdir $WORKSPACE_DIR
fi
if [ ! -d "$IDEA_SYS_DIR" ]; then
    mkdir $IDEA_SYS_DIR
fi
if [ ! -d "$IDEA_USR_DIR" ]; then
    mkdir $IDEA_USR_DIR
fi
xhost +
docker run \
    --rm \
    -it \
    -v $WORKSPACE_DIR:/home/giles/workspace \
    -v $IDEA_SYS_DIR:/home/giles/.IdeaIC \
    -v $IDEA_USR_DIR:/home/giles/.idea \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e DISPLAY=$DISPLAY \
    --name javadev \
    gilesp/javadev \
    /sbin/my_init \
    --skip-startup-files \
    --quiet \
    -- /sbin/setuser giles idea.sh
xhost -
