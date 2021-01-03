#Installs Media SDK 20.5.1

#!/bin/bash
set -e

 
echo "******************************************"
echo "*** Building and installing Media SDK  ***"
echo "******************************************"
MSDKBASE=$(pwd)
sudo echo #to avoid the break at sudo make install
#wget https://github.com/Intel-Media-SDK/MediaSDK/archive/intel-mediasdk-20.5.1.tar.gz
rm -rf MediaSDK-intel-mediasdk-20.5.1/
tar -xvf intel-mediasdk-20.5.1.tar.gz
cd MediaSDK-intel-mediasdk-20.5.1/
mkdir build && cd build
cmake -DBUILD_TESTS=ON -DBUILD_TOOLS=ON ..
time make -j$(nproc)
sudo make -j$(nproc) install
cd $MSDKBASE

