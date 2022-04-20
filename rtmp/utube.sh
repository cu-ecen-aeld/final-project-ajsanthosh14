# stream video to youtube live streaming

gst-launch-1.0 -v videotestsrc ! decodebin ! videoconvert ! x264enc ! video/x-h264 ! h264parse ! flvmux streamable=true name=mux ! rtmpsink location="rtmp://a.rtmp.youtube.com/live2/7t9h-dwt1-9zfe-pgtq-9411" audiotestsrc ! voaacenc bitrate=128000 ! mux.
