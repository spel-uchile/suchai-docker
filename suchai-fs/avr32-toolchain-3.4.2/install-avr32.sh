#!/bin/bash
package_name="AVR32 Tool Chain"
arch=`uname -m`

version="${1:-3.4.2.435}"
header="${2:-6.1.3.1475}"
prefix=${3:-/usr/local}

echo $header $version $prefix

function check_install_file {
	install_file=$1
	if [ ! -f "$install_file" ]; then
		echo "Installation file $install_file not found"
		exit 1
	fi
	#return 1
}

set -e
dry_run="no"
while test $# -gt 0; do
	arg=$1
	if [ "$arg" == "-d" ]; then
		dry_run="yes"
	fi
	if [ "$arg" == "-h" ]; then
		echo "Usage: $0 [-d] [-h] [[[version] [header]] prefix]"
		echo "       -d   : dry run, dont install, just test"
		echo "       -h   : print this help text"
		exit 2
	fi
	shift
done

echo "Verifying $package_name installation files ($arch)"
check_install_file avr32-gnu-toolchain-$version-linux.any.$arch.tar.gz
check_install_file avr32-utilities-$arch.tar.gz
check_install_file atmel-headers-$header.zip
echo "$package_name installation files verified OK"

# Install toolchain
echo "Installing $package_name $version Binaries for $arch in $prefix"
tar xfz avr32-gnu-toolchain-$version-linux.any.$arch.tar.gz

if [ ! -d $prefix/avr32 ]; then mkdir $prefix/avr32; fi
echo "avr32-gnu-toolchain-linux_$arch ($version) in $prefix/avr32/"
echo $prefix/avr32/ >> manifest.txt
cp -ra avr32-gnu-toolchain-linux_$arch/* $prefix/avr32/
rm -rf ./avr32-gnu-toolchain-linux_$arch

# Install utilities
tar xfz avr32-utilities-$arch.tar.gz
echo "#$prefix/bin $prefix/share $prefix/etc" >> manifest.txt
ls  avr32-utilities-$arch/* >> manifest.txt

echo "Installing avr32-utilities-$arch/bin utilities in $prefix/bin"
if [ ! -d $prefix/bin ]; then mkdir $prefix/bin; fi
cp -ra avr32-utilities-$arch/bin/* $prefix/bin

echo "Installing avr32-utilities-$arch/share utilities in $prefix/share"
if [ ! -d $prefix/share ]; then mkdir $prefix/share; fi
cp -ra avr32-utilities-$arch/share/* $prefix/share

echo "Installing avr32-utilities-$arch/etc utilities in $prefix/etc"
if [ ! -d $prefix/etc ]; then mkdir $prefix/etc; fi
cp -ra avr32-utilities-$arch/etc/* $prefix/etc
rm -rf avr32-utilities-$arch

# Install headers
echo "Installing atmel-headers-$header/avr32/ Headers in $prefix/avr32/avr32/include/"
unzip -q atmel-headers-$header.zip
cp -ra atmel-headers-$header/avr32/ $prefix/avr32/avr32/include/

echo "#$prefix/avr32/avr32/include/" >> manifest.txt
ls $prefix/avr32/avr32/include/* >> manifest.txt
rm -rf atmel-headers-$header

# Setup path
echo "Setting PATH"
add_to_path="$prefix/avr32/bin:$prefix/bin"
if ! grep -q "PATH.*$add_to_path" ~/.profile; then
    echo "Setting up PATH: Adding $add_to_path to PATH"
    echo "#~/.profile" >> manifest.txt  
    echo "PATH=\$PATH:$add_to_path" >> manifest.txt
    echo "PATH=\$PATH:$add_to_path" >> ~/.profile
    export PATH=\$PATH:$add_to_path
    echo $PATH
fi

# Setup aliases
if ! grep -q "alias waf" ~/.bash_aliases; then
    echo "Setting up aliases"
    echo "alias waf=./waf" >> ~/.bash_aliases
    echo "alias a=ack-grep" >> ~/.bash_aliases
fi

echo "Installation completed OK"
