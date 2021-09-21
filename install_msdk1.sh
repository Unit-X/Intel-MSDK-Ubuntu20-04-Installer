#Installs Media SDK 21.1.3

#!/bin/bash
set -e

sudo apt -y update && sudo apt -y upgrade
sudo apt install -y gdb build-essential cmake autoconf libtool libdrm-dev pkg-config libpciaccess-dev xutils-dev libx11-dev xorg-dev

MSDKBASE=$(pwd)

# libva
echo "**************************************"
echo "*** Building and installing libva  ***"
echo "**************************************"
# wget -O libva-2.12.0.tar.gz https://github.com/intel/libva/archive/refs/tags/2.12.0.tar.gz
rm -rf libva-2.12.0
tar -xvf libva-2.12.0.tar.gz
cd libva-2.12.0/
./autogen.sh --prefix=/usr --libdir=/usr/lib/x86_64-linux-gnu
time make -j$(nproc)
sudo make -j$(nproc) install

# libva-utils
echo "********************************************"
echo "*** Building and installing libva-utils  ***"
echo "********************************************"
cd $MSDKBASE
# wget -O libva-utils-2.12.0.tar.gz https://github.com/intel/libva-utils/archive/refs/tags/2.12.0.tar.gz
rm -rf libva-utils-2.12.0
tar -xvf libva-utils-2.12.0.tar.gz
cd libva-utils-2.12.0/
./autogen.sh
time make -j$(nproc)
sudo make -j$(nproc) install

# gemlib
echo "***************************************"
echo "*** Building and installing gemlib  ***"
echo "***************************************"
cd $MSDKBASE
# wget https://github.com/intel/gmmlib/archive/refs/tags/intel-gmmlib-21.3.1.tar.gz
rm -rf gmmlib-intel-gmmlib-21.3.1
tar -xvf intel-gmmlib-21.3.1.tar.gz
cd gmmlib-intel-gmmlib-21.3.1/
mkdir -p build_gmm && cd build_gmm
cmake -DCMAKE_BUILD_TYPE=Release ..
time make -j$(nproc)
sudo make -j$(nproc) install

# media-driver
echo "*********************************************"
echo "*** Building and installing media-driver  ***"
echo "*********************************************"
cd $MSDKBASE
# wget https://github.com/intel/media-driver/archive/refs/tags/intel-media-21.2.3.tar.gz
rm -rf media-driver-intel-media-21.2.3/
tar -xvf intel-media-21.2.3.tar.gz
cd media-driver-intel-media-21.2.3/
mkdir -p build_md && cd build_md
cmake -DCMAKE_BUILD_TYPE=Release ..
time make -j$(nproc)
sudo make -j$(nproc) install

if [[ -z "${LIBVA_DRIVERS_PATH}" ]]; then
  sudo sh -c "echo 'LIBVA_DRIVERS_PATH=/usr/lib/x86_64-linux-gnu/dri' >> /etc/environment"
fi
if [[ -z "${LIBVA_DRIVER_NAME}" ]]; then
  sudo sh -c "echo 'LIBVA_DRIVER_NAME=iHD' >> /etc/environment"
fi

sudo usermod -a -G video,render $USER

#reboot
echo
echo "Reboot system by typing -> sudo reboot now"
echo



