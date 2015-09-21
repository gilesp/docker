# Docker container for React Native Android development

This dockerfile will build a debian based container that encapsulates node, the android sdk and react native.

It started as a way for me to try out React Native without having to install everything on my host machine.

The dockerfile is not optimised currently, as I wanted ease of use/understanding first. I'll probably streamline it as I use it in anger.

## Setup

    docker build -t react-native .

### Install udev rules

On your host system, you'll need to install the android udev rules if you want to connect your phone or tablet via USB and deploy the react native app directly to it. You can get the rules from http://source.android.com/source/51-android.rules and you can install them as follows:

    wget -S -O - http://source.android.com/source/51-android.rules | sed "s/<username>/$USER/" | sudo tee >/dev/null /etc/udev/rules.d/51-android.rules
    sudo udevadm control --reload-rules
    
## Scripts

There are a few simple shell scripts to make interacting with the container easier, so you'll probably want to symlink those to your /home/bin directory.

They all assume that the current working directory is where your project is to be stored

### react-native.sh

Convenience script to run react-native command in the current directory. Most useful for initialising your project

    $ react-native.sh init AwesomeProject

You can then edit the code in the AwesomeProject directory

### run_server.sh

Simply runs react-native start but handles port forwarding

    $ cd AwesomeProject
    $ run_server.sh
    
### react_bash.sh

This is the main script that I use. It gives you a command prompt on the container and is handy for day to day development work. I currently use this to run the app on my phone, connected via usb as follows:

    $ react_bash.sh
    root@container $ react-native start > /dev/null 2>&1 &
    root@container $ adb reverse tcp:8081 tcp:8081
    root@container $ react-native run-android

You can then edit your code as normal and see it instantly updated on the device.

This script maps the /tmp/.X11-unix directory which should contain your X Windows socket, thus allowing you to run graphical applications (such as the android GUI tools) from within the container.