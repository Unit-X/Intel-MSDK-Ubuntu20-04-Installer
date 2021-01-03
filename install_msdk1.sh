#Installs Media SDK 20.5.1

#!/bin/bash
set -e

sudo apt -y update && sudo apt -y upgrade 
sudo apt install -y gdb build-essential cmake autoconf libtool libdrm-dev pkg-config libpciaccess-dev xutils-dev libx11-dev xorg-dev

# libva
echo "**************************************"
echo "*** Building and installing libva  ***"
echo "**************************************"
rm -rf ~/vaapi && mkdir ~/vaapi && cd ~/vaapi
#wget https://github.com/intel/libva/archive/2.10.0.tar.gz
tar -xvf 2.10.0.tar.gz
cd libva-2.10.0/
./autogen.sh --prefix=/usr --libdir=/usr/lib/x86_64-linux-gnu
time make -j$(nproc)
sudo make -j$(nproc) install
rm 2.10.0.tar.gz

# libva-utils
echo "********************************************"
echo "*** Building and installing libva-utils  ***"
echo "********************************************"
cd ~/vaapi
#wget https://github.com/intel/libva-utils/archive/2.10.0.tar.gz
tar -xvf tool-2.10.0.tar.gz
cd libva-utils-2.10.0/
./autogen.sh 
time make -j$(nproc)
sudo make -j$(nproc) install

# gemlib
echo "***************************************"
echo "*** Building and installing gemlib  ***"
echo "***************************************"
cd ~/vaapi
#wget https://github.com/intel/gmmlib/archive/intel-gmmlib-20.4.1.tar.gz
tar -xvf intel-gmmlib-20.4.1.tar.gz
cd gmmlib-intel-gmmlib-20.4.1/
mkdir -p build_gmm && cd build_gmm
cmake -DCMAKE_BUILD_TYPE=Release ..
time make -j$(nproc)
sudo make -j$(nproc) install 

# media-driver
echo "*********************************************"
echo "*** Building and installing media-driver  ***"
echo "*********************************************"
cd ~/vaapi
#wget https://github.com/intel/media-driver/archive/intel-media-20.4.5.tar.gz
tar -xvf intel-media-20.4.5.tar.gz
cd media-driver-intel-media-20.4.5/
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



