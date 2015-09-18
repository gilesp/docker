#!/bin/sh
#
# Run "react-native start" on the project in the current working directory
#
docker run --rm -it -v $(pwd):/app -p 8081:8081 react-native react-native start
