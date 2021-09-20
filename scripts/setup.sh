#!/bin/sh

export DLC=/psc/dlc
export PATH=$DLC/bin:$PATH
docker login
sudo yum -y install htop 
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

if [ ! -d /usr/lib/jvm/jdk ]
then
    sudo ln -s /usr/lib/jvm/java-11-amazon-corretto.x86_64 /usr/lib/jvm/jdk
fi

mkdir -p ~/install
if [ ! -f /home/ec2-user/install/12.3.0.tar.gz ]
then
    aws s3 cp s3://mysupportfiles2/12.3.0.tar.gz ~/install
    tar xzvCf ~/install ~/install/12.3.0.tar.gz
fi

if [ ! -d /psc ]
then
    sudo /home/ec2-user/install/12.3.0/proinst -b /home/ec2-user/install/12.3.0/response_oedev.ini -l /tmp/output.log
fi

cp -f /psc/dlc/progress.cfg ~/pasoe-sample-app/oedb/build/license
cp -f /psc/dlc/progress.cfg ~/pasoe-sample-app/deploy/license

cd ~/pasoe-sample-app/oedb/build
./build.sh

docker run -d -p 20000:20000 -p 3000-3200:3000-3200 -e DB_BROKER_PORT=20000 -e DB_MINPORT=3000 -e DB_MAXPORT=3200 oedb1

cd ~/pasoe-sample-app/Sports
proant package
cp ~/pasoe-sample-app/Sports/output/package-output/Sports.zip ~/pasoe-sample-app/deploy/ablapps/

cd ~/pasoe-sample-app/deploy
proant deploy

#
