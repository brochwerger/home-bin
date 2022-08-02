#! /bin/sh
# Preq: dnf install v4l2ucp v4l-utils

location=$1

#v4l2-ctl -d /dev/video4 --set-ctrl zoom_absolute=125
v4l2-ctl -d /dev/video4 --set-ctrl brightness=100

if [ "$location" = "poas" ]
then
    v4l2-ctl -d /dev/video4 --set-ctrl zoom_absolute=110
    v4l2-ctl -d /dev/video4 --set-ctrl tilt_absolute=-36000
elif [ "$location" = "yaffo" ]
then
    v4l2-ctl -d /dev/video4 --set-ctrl zoom_absolute=115
    v4l2-ctl -d /dev/video4 --set-ctrl tilt_absolute=-36000
else
    echo 'Usage: camera-setup yaffo|poas'
fi

