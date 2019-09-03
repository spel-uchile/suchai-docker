# Use an official Ubuntu runtime as a parent image
#FROM suchai-fs
FROM ubuntu:16.04

# Set the working directory to /app
WORKDIR /spel

# Copy the current directory contents into the container at /app
COPY . /spel

# Install any needed packages specified in requirements.txt
RUN apt-get update
RUN apt-get -y install $(cat dependencies.txt)

# Make port 80 available to the world outside this container
#EXPOSE 80

# Define environment variable
ENV USER spel
ENV PATH $PATH:/usr/local/avr32/bin

# Set the locale
RUN locale-gen C 
ENV LANG C
ENV LANGUAGE C  
ENV LC_ALL C

RUN cd /spel/avr32-toolchain-3.4.2; ./install-avr32.sh

# Run this when the container launches
#CMD sh install.sh
