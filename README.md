# SUCHAI Flight Software Docker

This Dockerfile is used to create a container to build and program the [SUCHAI Flight Software](https://github.com/spel-uchile/SUCHAI-Flight-Software) using the AVR32 toolchain.

It uses the oficial Ubuntu 16.04 image and installs the required dependencies to build the software. It also installs the AVR32 toolchain and utilities.

## Usage

- Install Docker in your OS.

    ```bash
    # For Ubuntu and similar
    sudo apt-get install docker
    
    # For Arch Linux and similar
    sudo pacman -S docker
    ```
    
- Clone a build the image using `suchai-fs` tag. This will install al required dependencies and AVR32 toolchain.

    ```bash
    # Clone this repository and open the directory
    git clone https://github.com/spel-uchile/suchai-docker.git
    cd suchai-docker
    
    # Build the image
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
