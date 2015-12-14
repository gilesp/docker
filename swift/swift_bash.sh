#!/bin/bash

CONTAINER_NAME=swift

# Function to determine if named docker instance is already running
check_running () {
    retval=0
    running=$(docker inspect --format="{{ .State.Running }}" "$CONTAINER_NAME" 2> /dev/null)
    if [ "$running" == "true" ]; then
        retval=1
    fi
    return "$retval"
}

check_running

if [ $? -eq 1 ]; then
	echo "$CONTAINER_NAME is already running." >&2
	exit 1
fi

docker run \
       --rm \
       -it \
       --user="$UID" \
       --privileged \
       -v /tmp/.X11-unix:/tmp/.X11-unix \
       -v $(pwd):/home/dev/app \
       --net host \
       -e DISPLAY="$DISPLAY" \
       --name $CONTAINER_NAME \
       swift /bin/bash
       
