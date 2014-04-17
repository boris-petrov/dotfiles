#!/bin/sh

sudo cp screenful/98-screen-detect.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules
sudo cp screenful/notify-awesome /lib/udev/
