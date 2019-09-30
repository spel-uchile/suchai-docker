# Use an official Ubuntu runtime as a parent image
#FROM suchai-fs
FROM ubuntu:16.04

# Set the working directory to /app
WORKDIR /spel

# Install any needed packages specified in requirements.txt
RUN apt-get update
RUN apt-get -y install build-essential cmake locales unzip wget nano grep git python python3 minicom libcunit1-dev libsqlite3-dev postgresql libpq-dev libzmq3-dev

# Make port 80 available to the world outside this container
#EXPOSE 80

# Copy the current directory contents into the container at /app
COPY . /spel

# Define environment variable
ENV USER spel
ENV PATH $PATH:/usr/local/avr32/bin

# Set the locale
RUN locale-gen en_US.UTF-8 
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

WORKDIR /spel/avr32-toolchain-3.4.2
RUN chmod +x install-avr32.sh
RUN ./install-avr32.sh

WORKDIR /spel

# Run this when the container launches
#CMD sh install.sh
