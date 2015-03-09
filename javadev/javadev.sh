#!/bin/bash
#
# Hideously messy bash script to "simplify" running and connecting to a docker
# instance.
#
# Currently, intellij should be started first as when started with docker exec
# the volumes don't seem to be mapped properly.
#
# So to have both intellij and a bash prompt open, execute the following:
#    javadev <projectname>    # To start intellij
#    javadev -s <projectname> # To open a bash prompt.
#

PROGNAME=$(basename $0)
INSTANCE_BASE="javadev"

usage () {
    cat <<EOF
Usage: $PROGNAME [-s] workspace_name
EOF
    exit 0
}

# Function to determine if named docker instance is already running
check_running () {
    retval=0
    running=$(docker inspect --format="{{ .State.Running }}" "$INSTANCE_BASE-$1" 2> /dev/null)
    if [ "$running" == "true" ]
    then
        retval=1
    fi
    return "$retval"
}

executable="idea.sh"

while getopts "s" opt ; do
    case $opt in
        s ) executable="/bin/bash" ;;
    esac
done

shift $(expr $OPTIND - 1 )

if [ "$#" -ne 1 ]; then
    usage
fi
project=$1
PROJECT_DIR=/home/giles/projects
WORKSPACE_DIR=$PROJECT_DIR/$project/workspace
IDEA_SYS_DIR=$PROJECT_DIR/$project/idea_sys
IDEA_USR_DIR=$PROJECT_DIR/$project/.idea
MVN_DIR=/home/giles/.m2 # Using my normal mvn cache but could be configured on
                        # per-project basis like the other directories.
if [ ! -d "$PROJECT_DIR/$project" ]; then
    mkdir $PROJECT_DIR/$project
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
check_running $project
instance_running=$?
if [ "$instance_running" == 0 ]
then
    # Start new instance
    echo "Starting new instance..."
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
        --name "$INSTANCE_BASE-$project" \
        gilesp/javadev \
        /sbin/my_init \
        --skip-startup-files \
        --quiet \
        -- /sbin/setuser giles $executable
else
    # Attach to running instance
    echo "Attaching to running instance..."
    docker exec -it "$INSTANCE_BASE-$project" /sbin/setuser giles $executable
fi
xhost -
