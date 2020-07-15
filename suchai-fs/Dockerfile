# Use an official Ubuntu runtime as a parent image
#FROM suchai-fs
FROM ubuntu:16.04

# Set the working directory to /app
WORKDIR /spel

# Install any needed packages specified in requirements.txt
RUN apt-get update && apt-get -y install build-essential cmake locales unzip wget nano grep git python python-pip python3 python3-pip minicom libcunit1-dev libsqlite3-dev postgresql libpq-dev libzmq3-dev pkg-config sudo

# Make port 80 available to the world outside this container
#EXPOSE 80

# Copy the current directory contents into the container at /app
COPY . /spel

# Define environment variable
ENV USER spel
ENV PATH $PATH:/usr/local/avr32/bin
ENV PATH $PATH:/spel/SUCHAI-Flight-Software/src/drivers/esp32/xtensa-esp32-elf/bin
ENV IDF_PATH=/spel/SUCHAI-Flight-Software/src/drivers/esp32/esp-idf

# Set the locale
RUN locale-gen en_US.UTF-8 
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

WORKDIR /spel/avr32-toolchain-3.4.2
RUN chmod +x install-avr32.sh
RUN ./install-avr32.sh

WORKDIR /spel
RUN git clone https://github.com/spel-uchile/SUCHAI-Flight-Software.git
# Run this when the container launches
#CMD sh install.sh
