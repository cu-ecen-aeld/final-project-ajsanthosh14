#!/bin/bash
#Script to build receiver/client gstreamer udp multi-cast pipeline
#Author: Santhosh

#Reference: gstreamer documentation
#Link: https://gstreamer.freedesktop.org/documentation/tools/gst-launch.html?gi-language=c

MULTICAST_IP=224.1.1.1
PORT=5000
VSRC=video_samples/sample.mp4

gst-launch-1.0 -v filesrc location=$VSRC ! \
        decodebin  ! videoconvert ! x264enc ! h264parse ! rtph264pay ! \
       	udpsink host=$MULTICAST_IP port=$PORT auto-multicast=true sync=true

