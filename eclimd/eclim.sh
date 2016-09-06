#!/bin/sh
# script to execute eclim within running docker image

docker exec -i "eclimd" /usr/local/eclipse/eclim "$@"
