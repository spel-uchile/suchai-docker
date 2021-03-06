# SUCHAI Flight Software Docker

This Dockerfile is used to create a container to build and program the [SUCHAI Flight Software](https://github.com/spel-uchile/SUCHAI-Flight-Software) using the AVR32 toolchain.

It uses the oficial Ubuntu 16.04 image and installs the required dependencies to build the software. It also installs the AVR32 toolchain and utilities.

## Usage

- Install Docker in your OS.

    ```bash
    # For Ubuntu and similar
    sudo apt-get install docker.io
    
    # For Arch Linux and similar
    sudo pacman -S docker
    
    # Add your user to the `docker` group, to run docker commands without sudo
    sudo usermod -aG docker ${USER}
    
    # Restart and (optionally) enable docker daemon
    sudo systemctl restart docker
    sudo systemctl enable docker
    ```
    
- Clone a build the image using `suchai-fs` tag. This will install al required dependencies and AVR32 toolchain.

    ```bash
    # Clone this repository and open the directory
    git clone https://github.com/spel-uchile/suchai-docker.git
    cd suchai-docker/suchai-fs
    
    # Build the image (please note the dot at the end)
    docker build -t suchai-fs ./suchai-fs
    ```
    
- Launch the container in interactive mode to download and install the [SUCHAI Flight Software](https://github.com/spel-uchile/SUCHAI-Flight-Software)

    ```bash
    # Run the container `suchai-fs` in interactive mode
    docker run -t -i suchai-fs /bin/bash
    
    # Run container `suchai-fs` with local ssh keys
    docker run -v ~/.ssh:/root/.ssh -t -i suchai-fs /bin/bash
    
    # Once in the container, download and configure the flight software
    sh install_build_nanomind.sh
    
    # Run container `suchai-fs` with local ssh keys and a custom command
    docker run -v ~/.ssh:/root/.ssh -it suchai-fs sh install_build_nanomind.sh
    ```
    
- Customize the build using the compile.py script inside the SUCHAI-Flight-Software directory. To show the option use.

    ```bash
    # Show compile.py help
    cd SUCHAI-Flight-Software
    python3 compile.py --help
    ```
    
- To program using the AVR.

    1. Exit the container
    2. Connect the USB programmer
    3. Determine where the USB programmer was attached
    
        ```bash
        lsusb
        
        #Bus 001 Device 002: ID 8087:8000 Intel Corp. 
        #Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
        #Bus 003 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
        #Bus 002 Device 004: ID 04f2:b39a Chicony Electronics Co., Ltd 
        #Bus 002 Device 003: ID 8087:07dc Intel Corp. 
        #Bus 002 Device 006: ID 03eb:2107 Atmel Corp. AVR Dragon            <-- AVR Dragon on BUS 002
        #Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
        ```
    
    4. In the example above, the AVR DRAGON is attached to USB BUS 002
    5. Run the container with access to the USB programmer
    
        ```bash
        docker run -i -t --device=/dev/bus/usb/{{USB_BUS_NUMBER}}/ suchai-fs /bin/bash
        ```
    6. Program the device
    
        ```bash
        cd SUCHAI-Flight-Software
        python3 compile.py FREERTOS NANOMIND --program
        ```
        
    

## Tips

1. Save changes made in a container. For example if you downloaded the flight software, configured and build it and want to save these changes to the image, use the `docker commit` command.

    ```bash
    #Check current container id
    docker ps
    
    # Example output:
    # CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
    # 367801c0802e        e52fc6148efd        "/bin/bash"         5 minutes ago       Up 5 minutes                            cocky_hugle
    
    # Commit current {CONTAINER_ID} changes to ```suchai-fs``` image
    docker commit {CONTAINER_ID}  suchai-fs
    ```

# Docker Compose

Run the following command:

```bash

docker-compose up

```

To ensure an image build before start process execute
```bash
docker-compose up --build
```

If you have a problem with cosmos-rb connecting to xorg server, 
add the following line at the end of of visudo file
```
Defaults env_keep="DISPLAY XAUTHORITY"
``` 

# GroundStation notes 

connect to ax100 with pyserial
```
miniterm /dev/ttyUSB2 500000
```
set csp_node in ax100

```
param list
param set csp_node 9 
```

run doppler python script
```
python3 doppler.py $OWN_NODE $SCH_GND_NODE --predict $HOST
python3 doppler.py 11 10 --predict 0.0.0.0

```

In Suchai FS ground station we need to configure com node
```
com_set_node 9

```

Rotctl command to enter interface
```
rotctl -m 601 -r /dev/ttyUSB0 -vvvv
```

There is a systemd archive in init.d files named controlrotor  
```
rotctld -m 201 -r /dev/ttyUSB0 -s 9600
```

Gpredict configuration should be:

- version 2.0
- Interface host 172.17.58.76
- Interface host 4532
- Interface radio type Duplex TRX
- Interface VFO MAIN SUB
- Rotator host 172.17.58.76
- Rotator port 4533
- Rotator az type 0->180 ->360




