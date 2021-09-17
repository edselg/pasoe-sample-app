#!/bin/sh

if [ ! -d /usr/lib/jvm/jdk ]
then
    sudo ln -s /usr/lib/jvm/java-11-amazon-corretto.x86_64 /usr/lib/jvm/jdk
fi

mkdir -p ~/install
#aws s3 cp s3://mysupportfiles2/12.3.0.tar.gz ~/install
#tar xzvCf ~/install ~/install/12.3.0.tar.gz

if [ ! -d /psc ]
then
    sudo /home/ec2-user/install/12.3.0/proinst -b /home/ec2-user/install/12.3.0/response_oedev.ini -l /tmp/output.log
fi

cp -f /psc/dlc/progress.cfg ~/pasoe-sample-app/oedb/build/license
