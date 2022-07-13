#! /bin/sh

v4l2-ctl -d /dev/video4 --set-ctrl zoom_absolute=125
v4l2-ctl -d /dev/video4 --set-ctrl tilt_absolute=-35000
v4l2-ctl -d /dev/video4 --set-ctrl brightness=90
