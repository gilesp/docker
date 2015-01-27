docker
======

A repository for my docker files

Currently it's an attempt to isolate specific build tools (java, android etc.) into containers yet still be able to do "local" development on the host machine.

My ultimate goal is to have a host machine that merely contains an editor, git and the project source files and the tools are containerised and can be used at will without version cross-contamination ( [particularly for those tools that insist on being installed via things like npm](https://twitter.com/bketelsen/status/526911869777641472) ).

Is this a good idea? Will it work? Won't my machine just fill up with single-use docker containers? I don't know, but I'm going to find out...
