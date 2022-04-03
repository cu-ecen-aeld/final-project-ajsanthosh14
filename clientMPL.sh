#!/bin/bash
#Script to build receiver/client gstreamer udp mutlicast reverse pipeline
#Author: Santhosh

#Reference: gstreamer documentation
#Link: https://gstreamer.freedesktop.org/documentation/tools/gst-launch.html?gi-language=c

MULTICAST_IP=224.1.1.1 
PORT=5000

gst-launch-1.0 -v udpsrc multicast-group=$MULTICAST_IP auto-multicast=true port=$PORT ! \
       	application/x-rtp  ! rtph264depay ! h264parse !  decodebin ! videoconvert ! \
       	autovideosink caps='video/x-raw, format=RGB'

