

#include <gst/gst.h>
#include <stdio.h>


GST_DEBUG_CATEGORY_STATIC (my_category);
#define GST_CAT_DEFAULT my_category

static GMainLoop *loop;

gint
main (gint   argc,
      gchar *argv[])
{
    GstElement *pipeline, *videosrc, *conv,*enc, *pay, *udp, *decode, *videox;

    // init GStreamer
    gst_init (&argc, &argv);
    loop = g_main_loop_new (NULL, FALSE);

    GST_DEBUG_CATEGORY_INIT (my_category, "my category", 0, "This is my very own");

    // setup pipeline
    pipeline = gst_pipeline_new ("pipeline");

    //videosrc = gst_element_factory_make("videotestsrc", "source");
    
    videosrc = gst_element_factory_make ("filesrc", "source");
    g_object_set(G_OBJECT(videosrc), "location", " ../video_samples/sample.mp4", NULL);

    decode = gst_element_factory_make("decodebin", "decode");

    conv = gst_element_factory_make ("videoconvert", "conv");

    enc = gst_element_factory_make("x264enc", "enc");

    videox = gst_element_factory_make("video/x-h264","videox");

    pay = gst_element_factory_make("rtph264pay", "pay");
    //g_object_set(G_OBJECT(pay), "config-interval", 1, NULL);

    udp = gst_element_factory_make("udpsink", "udp");
    g_object_set(G_OBJECT(udp), "host", "10.0.0.83", NULL);
    g_object_set(G_OBJECT(udp), "port", 5000, NULL);


    gst_bin_add_many (GST_BIN (pipeline), videosrc, decode, conv, enc, videox, pay, udp, NULL);

    
    if (gst_element_link_many ( videosrc, decode, conv,  enc, videox, pay, udp, NULL) != TRUE)
    {
        g_printerr ("Elements could not be linked.\n");
        gst_object_unref (pipeline);
        return -1;
    }
    
/*
    if(gst_element_link_many(decode, conv , enc) != TRUE){
    	printf("Can't link videosrc to decoder\n");
    }
*/
    // play
    gst_element_set_state (pipeline, GST_STATE_PLAYING);

    g_main_loop_run (loop);

    // clean up
    gst_element_set_state (pipeline, GST_STATE_NULL);
    gst_object_unref (GST_OBJECT (pipeline));
    g_main_loop_unref (loop);

    return 0;
}
