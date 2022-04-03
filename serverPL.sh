#!/bin/bash
#Script to build transmitter/server gstreamer udp pipeline
#Author: Santhosh

#Reference: gstreamer documentation
#Link: https://gstreamer.freedesktop.org/documentation/tools/gst-launch.html?gi-language=c

IP=$(ip route get 8.8.8.8 | grep -oP 'src \K[^ ]+')

echo BRADCASTING with IP address: $IP

#Broadcasts only video portion of MPEG video file
gst-launch-1.0 -v filesrc location =video_samples/sample.mp4 ! decodebin ! x264enc ! rtph264pay ! udpsink host=$IP port=5000 

# Get public ip 
#echo $(dig +short myip.opendns.com @resolver1.opendns.com)


