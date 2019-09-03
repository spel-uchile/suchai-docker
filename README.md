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
    cd suchai-docker
    
    # Build the image (please note the dot at the end)
    docker build -t suchai-fs .
    ```
    
- Launch the container in interactive mode to download and install the [SUCHAI Flight Software](https://github.com/spel-uchile/SUCHAI-Flight-Software)

    ```bash
    # Run de container `suchai-fs` in interactive mode
    docker run -t -i suchai-fs /bin/bash
    
    # Once in the container, download and configure the flight software
    sh install.sh
    
    # Finally build
    sh build.sh
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
