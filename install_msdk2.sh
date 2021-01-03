#Installs Media SDK 20.5.1

#!/bin/bash
set -e

 
echo "******************************************"
echo "*** Building and installing Media SDK  ***"
echo "******************************************"

sudo echo #to avoid the break at sudo make install
cd ~/vaapi
#wget https://github.com/Intel-Media-SDK/MediaSDK/archive/intel-mediasdk-20.5.1.tar.gz
tar -xvf intel-mediasdk-20.5.1.tar.gz
cd MediaSDK-intel-mediasdk-20.5.1/
mkdir build && cd build
cmake -DBUILD_TESTS=ON -DBUILD_TOOLS=ON ..
time make -j$(nproc)
sudo make -j$(nproc) install


