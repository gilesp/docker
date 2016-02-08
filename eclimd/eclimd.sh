#!/bin/bash
Xvfb :1 -screen 0 1024x768x24 &
DISPLAY=:1 /usr/local/eclipse/eclimd -b
