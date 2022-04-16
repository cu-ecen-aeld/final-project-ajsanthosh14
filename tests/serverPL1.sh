#!/bin/bash
#Script to build transmitter/server gstreamer udp unicast pipeline
#Author: Santhosh

#Reference: gstreamer documentation
#Link: https://gstreamer.freedesktop.org/documentation/tools/gst-launch.html?gi-language=c


#Video source
VSRC=sample.mp4


# Get public ip 
#echo $(dig +short myip.opendns.com @resolver1.opendns.com)



#Broadcasting only video portion of MPEG video file

#TARGET_IP=$(ip route get 8.8.8.8 | grep -oP 'src \K[^ ]+')
TARGET_IP=10.0.0.83
PORT=5000

echo STREAMING TO IP address: $TARGET_IP

#gst-launch-1.0 -v videotestsrc  ! \
#       	decodebin ! x264enc ! rtph264pay ! udpsink host=$IP port=$PORT


gst-launch-1.0 -v filesrc location=$VSRC ! \
        decodebin ! videoconvert ! x264enc ! video/x-h264 ! rtph264pay ! udpsink host=$TARGET_IP port=$PORT 
