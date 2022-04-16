#!/bin/bash
#Script to build transmitter/server gstreamer udp unicast pipeline
#Author: Santhosh

#Reference: gstreamer documentation
#Link: https://gstreamer.freedesktop.org/documentation/tools/gst-launch.html?gi-language=c


#Video source
VSRC=sample.mp4

# Audio+Video broadcasting over UDP

#TARGET_IP=$(ip route get 8.8.8.8 | grep -oP 'src \K[^ ]+')
TARGET_IP=10.0.0.83
PORT=5000


echo STREAMING TO IP address: $TARGET_IP

gst-launch-1.0 -v filesrc location=$VSRC ! \
       	decodebin name=dec ! videoconvert ! x264enc ! video/x-h264 ! mpegtsmux name=mux ! queue ! udpsink host=$TARGET_IP port=$PORT sync=true \
       	dec. ! queue ! audioconvert ! voaacenc ! aacparse ! audio/mpeg ! queue ! mux.

: '
gst-launch-1.0 -v filesrc location=$VSRC ! \
	! qtdemux name=demux mpegtsmux name=mux alignment=7 \
	! rtpmp2tpay\
	!udpsink host=$TARGET_IP port=$PORT \
	demux. ! queue ! h264parse ! decodebin !  x264enc ! video/x-h264 ! mux.\
	demux. ! queue ! aacparse ! mux.
'

: '
gst-launch-1.0 -v filesrc location=$VSRC \
  ! decodebin name=demux mpegtsmux name=mux alignment=7 \
  ! rtpmp2tpay \
  ! udpsink host=$TARGET_IP port=5000 demux. \
  ! videoconvert ! x264enc ! video/x-h264 ! queue ! mux. demux. \
  ! queue ! audioconvert ! voaacenc ! audio/mpeg ! queue ! mux.
 '
