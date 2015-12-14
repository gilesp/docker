# Docker container for Swift development under linux

This dockerfile will build an ubuntu 15.10 based container that encapsulates the open source version of Swift

## Setup

    docker build -t swift .

## Scripts

There are a few simple shell scripts to make interacting with the container easier, so you'll probably want to symlink those to your /home/bin directory.

They all assume that the current working directory is where your project is to be stored

### swift.sh

Convenience script to run swift command in the current directory. Most useful for using the REPL or building a project

    $ swift build


### swift_bash.sh

This script gives you a command prompt on the container and may be handy for day to day development work.