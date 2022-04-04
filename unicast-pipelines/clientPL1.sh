#!/bin/bash
#Script to build receiver/client gstreamer udp unicast reverse pipeline
#Author: Santhosh

#Reference: gstreamer documentation
#Link: https://gstreamer.freedesktop.org/documentation/tools/gst-launch.html?gi-language=c

#Streams only video portion of MPEG video file received

PORT=5000

gst-launch-1.0 -v udpsrc port=$PORT \
	caps="application/x-rtp, media=video, clock-rate=90000, encoding-name=(string)H264, payload=(int)96" ! \
       	rtph264depay ! decodebin ! videoconvert ! autovideosink sync=false 

