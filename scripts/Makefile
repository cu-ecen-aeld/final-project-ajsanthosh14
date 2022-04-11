# Makfile to build the server application

CC = gcc

#compiler flags
CFLAGS = -g -Wall -Werror

OTHF = `pkg-config --cflags --libs gstreamer-1.0`

#source files
SRCS = server.c

#object files
OBJS = $(SRCS:.c=.o)

#Executable Target file
TARGET = server


all: $(TARGET)

$(TARGET): $(SRCS)
	$(CC) $(SRCS) -o $(TARGET) $(OTHF)


.PHONY: clean

clean:
	$(RM) $(TARGET) *.o 
