#!/bin/sh
docker run --rm -it -v $(pwd):/app --name react-native -p 8081:8081 react-native react-native "$@"
