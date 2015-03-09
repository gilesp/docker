#!/bin/sh

progname=$0

usage () {
    cat <<EOF
Usage: $progname [-s] workspace_name
EOF
    exit 0
}

name="javadev"
executable="idea.sh"

while getopts "s" opt ; do
    case $opt in
        s )
            executable="/bin/bash"
            name="javadev-shell"
            ;;
    esac
done

shift $(expr $OPTIND - 1 )

if [ "$#" -ne 1 ]; then
    usage
fi

PROJECT_DIR=/home/giles/projects
WORKSPACE_DIR=$PROJECT_DIR/$1/workspace
IDEA_SYS_DIR=$PROJECT_DIR/$1/idea_sys
IDEA_USR_DIR=$PROJECT_DIR/$1/.idea
MVN_DIR=/home/giles/.m2 # Using my normal mvn cache but could be configured on
                        # per-project basis like the other directories.
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
    --dns=192.168.37.8 \
    --dns=192.168.37.9 \
    -v $MVN_DIR:/home/giles/.m2 \
    -v $WORKSPACE_DIR:/home/giles/workspace \
    -v $IDEA_SYS_DIR:/home/giles/.IdeaIC \
    -v $IDEA_USR_DIR:/home/giles/.idea \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e DISPLAY=$DISPLAY \
    --name $name \
    gilesp/javadev \
    /sbin/my_init \
    --skip-startup-files \
    --quiet \
    -- /sbin/setuser giles $executable
xhost -
