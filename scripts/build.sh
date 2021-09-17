#!/bin/sh

#if [ ! -d /usr/lib/jvm/jdk ]
#then
#    sudo ln -s /usr/lib/jvm/java-11-amazon-corretto.x86_64 /usr/lib/jvm/jdk
#fi

cd ~/pasoe-sample-app/oedb/build/
./build.sh
export DLC=/psc/dlc
export PATH=$PATH:$DLC/bin
cd ~/pasoe-sample-app/Sports
proant package
