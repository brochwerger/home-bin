#! /bin/sh
# Preq: dnf install v4l2ucp v4l-utils

help()
{
   # Display Help
   echo "Add description of the script functions here."
   echo
   echo "Usage: camera-setup -l <location> -c <camera> -g"
}

location="yaffo"
camera="922"

while getopts ":l:c:gh" option; do
   case $option in
	l) location=$OPTARG;;
	c) camera=$OPTARG;;
    g) fire_gui=true;; # Invoke graphical configurator
    h) 
        help
        exit;;
    \?) # Invalid option
        echo "Error: Invalid option"
        exit;;
   esac
done

device=$(v4l2-ctl --list-devices | awk -v camera="$camera" 'c&&!--c; index($0,camera){c=1}' | sed -e 's/^[[:space:]]*//')

echo $camera
echo $location
echo $device

if [ $fire_gui ]
then
    guvcview --control_panel -d $device >& /dev/null
else 

    #v4l2-ctl -d $device --set-ctrl zoom_absolute=125
    v4l2-ctl -d $device --set-ctrl brightness=100
    v4l2-ctl -d $device --set-ctrl saturation=128
    v4l2-ctl -d $device --set-ctrl tilt_absolute=-36000

    if [ "$location" = "poas" ]
    then
        v4l2-ctl -d $device --set-ctrl zoom_absolute=110
    elif [ "$location" = "yaffo" ]
    then
        v4l2-ctl -d $device --set-ctrl zoom_absolute=115
        v4l2-ctl -d $device --set-ctrl backlight_compensation=1
    elif [ "$location" = "z-gila" ]
    then
        v4l2-ctl -d $device --set-ctrl zoom_absolute=125
        v4l2-ctl -d $device --set-ctrl brightness=150
        v4l2-ctl -d $device --set-ctrl tilt_absolute=-6000

    fi

fi