/*************************************************************************************************
 *
 * S22-AESD-Final_Project
 * 
 * @file server.c
 * @description Application to stream a locally stored video over udp using GStreamer 
 * @usage ./server <TARGET_IP>
 *
 * @author Santhosh, santhosh@colorado.edu
 * @created on April 7, 2022
 * Ref: https://gstreamer.freedesktop.org/documentation/
 ************************************************************************************************/
 
#include <gst/gst.h>
#include <stdio.h>

static GMainLoop *loop;

gint
main (gint   argc,
      gchar *argv[])
{
       	
    GstElement *pipeline, *videosrc, *conv,*enc, *pay, *udp;
    GstStateChangeReturn ret;

    // Initialize GStreamer
    gst_init (&argc, &argv);
    loop = g_main_loop_new (NULL, FALSE);

    // Set-up pipeline
    pipeline = gst_pipeline_new ("pipeline");

    // Create the elements
    videosrc = gst_element_factory_make("videotestsrc", "source");
    conv = gst_element_factory_make ("videoconvert", "conv");
    enc = gst_element_factory_make("x264enc", "enc");
    pay = gst_element_factory_make("rtph264pay", "pay");
    udp = gst_element_factory_make("udpsink", "udp");
    g_object_set(G_OBJECT(udp), "host", argv[1], NULL);
    g_object_set(G_OBJECT(udp), "port", 5000, NULL);


    // Check all the elemets are linkable    
    if(!pipeline || !videosrc || !conv || !enc || !pay || !udp){
    	g_printerr("Not all elements could be created!\n");
    	return -1;
    
    }

    // Building the pipeline
    gst_bin_add_many (GST_BIN (pipeline), videosrc, conv, enc, pay, udp, NULL);

    // link all the elements and validate 
    if (gst_element_link_many ( videosrc, conv, enc, pay, udp, NULL) != TRUE){
        g_printerr("Elements could not be linked!\n");
        return -1;
    }
    

    // Start playing
    ret = gst_element_set_state (pipeline, GST_STATE_PLAYING);
    if(ret == GST_STATE_CHANGE_FAILURE){
    	g_printerr("Unable to set the pipeline to the plaing state!\n");
    	return -1;
    }	


    g_main_loop_run (loop);

    // clean up
    gst_element_set_state (pipeline, GST_STATE_NULL);
    gst_object_unref (GST_OBJECT (pipeline));
    g_main_loop_unref (loop);

    return 0;
}
