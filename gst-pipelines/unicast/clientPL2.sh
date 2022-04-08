#!/bin/bash
#Script to build receiver/client gstreamer udp unicast reverse pipeline
#Author: Santhosh

#Reference: gstreamer documentation
#Link: https://gstreamer.freedesktop.org/documentation/tools/gst-launch.html?gi-language=c

#Streams only video+Audio of MPEG video file received using reversee piepeline


PORT=5000


gst-launch-1.0 -v udpsrc port=$PORT ! 'application/x-rtp,clock-rate=(int)90000,media=(string)video,payload=(int)96,encoding-name=(string)MP2T' \
	! rtpmp2tdepay ! tsparse ! decodebin name=dec \
	dec. ! queue ! videoconvert ! autovideosink sync=false \
        dec. ! queue ! audioconvert ! autoaudiosink sunc=false	




#Trials

# receiver
#gst-launch-1.0 -v udpsrc port=5000 \
#  ! 'application/x-rtp,clock-rate=(int)90000,media=(string)video,payload=(int)96,encoding-name=(string)MP2T' \
#  ! rtpmp2tdepay ! tsparse ! tsdemux name=demux \
#  demux. ! queue ! decodebin ! videoconvert ! fpsdisplaysink text-overlay=false sync=false \
#  demux. ! queue ! decodebin ! audioconvert ! autoaudiosink sync=false

