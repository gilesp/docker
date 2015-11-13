#!/bin/bash

CONTAINER_NAME=reactnative

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
       -v /dev/bus/usb:/dev/bus/usb \
       -v /home/$USER/.android:/home/dev/.android \
       -v $(pwd):/home/dev/app \
       --net host \
       -e DISPLAY="$DISPLAY" \
       --name $CONTAINER_NAME \
       react-native /bin/bash
       
