#!/bin/sh
docker run \
       --rm \
       -it \
       eclimd \
       /usr/bin/xvfb-run /usr/local/eclipse/eclimd -b  "$@"
