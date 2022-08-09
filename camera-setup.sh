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
camera="video4"

while getopts ":l:c:gh" option; do
   case $option in
	l) location=$OPTARG;;
	c) camera=$OPTARG;;
    g) # Invoke graphical configurator
        guvcview --control_panel -d /dev/$camera >& /dev/null
        exit;;
    h) 
        help
        exit;;
    \?) # Invalid option
        echo "Error: Invalid option"
        exit;;
   esac
done

echo $camera
echo $location

#v4l2-ctl -d /dev/$camera --set-ctrl zoom_absolute=125
v4l2-ctl -d /dev/$camera --set-ctrl brightness=100
v4l2-ctl -d /dev/$camera --set-ctrl saturation=128
v4l2-ctl -d /dev/$camera --set-ctrl tilt_absolute=-36000

if [ "$location" = "poas" ]
then
    v4l2-ctl -d /dev/$camera --set-ctrl zoom_absolute=110
elif [ "$location" = "yaffo" ]
then
    v4l2-ctl -d /dev/$camera --set-ctrl zoom_absolute=115
    v4l2-ctl -d /dev/$camera --set-ctrl backlight_compensation=1
elif [ "$location" = "z-gila" ]
then
    v4l2-ctl -d /dev/$camera --set-ctrl zoom_absolute=125
    v4l2-ctl -d /dev/$camera --set-ctrl brightness=150
    v4l2-ctl -d /dev/$camera --set-ctrl tilt_absolute=-6000

# else
#     echo 'Usage: camera-setup yaffo|poas|z-gila'
fi

