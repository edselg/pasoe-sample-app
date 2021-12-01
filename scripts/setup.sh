#!/bin/sh

export TERM=vt100
export PROJECT_HOME=~/environment/pasoe-sample-app
export DLC=/psc/dlc
export PATH=$DLC/bin:$PATH
export DOCKER_BUILDKIT=1
export ERROR_FILE=/tmp/errors.$$

echo `date +%H:%M:%S`: Setup Begin
mkdir -p ~/environment/.c9/builders
cp $PROJECT_HOME/scripts/ABL.build -p ~/environment/.c9/builders
mkdir -p ~/environment/.c9/runners
cp $PROJECT_HOME/scripts/ABL.run -p ~/environment/.c9/runners
cp $PROJECT_HOME/scripts/ABL-PROC.run -p ~/environment/.c9/runners

export MAC_ADDRESS=`curl -s http://169.254.169.254/latest/meta-data/mac`
export PUBLIC_IP_ADDRESS=`curl -s http://169.254.169.254/latest/meta-data/network/interfaces/macs/${MAC_ADDRESS}/public-ipv4s`
export PRIVATE_IP_ADDRESS=`curl -s http://169.254.169.254/latest/meta-data/local-ipv4`

echo `date +%H:%M:%S`: Tailoring Project Files
cp $PROJECT_HOME/Sports/conf/startup.pf.src $PROJECT_HOME/Sports/conf/startup.pf
cp $PROJECT_HOME/deploy/conf/runtime.properties.src $PROJECT_HOME/deploy/conf/runtime.properties
cp $PROJECT_HOME/webui/grid.js.src $PROJECT_HOME/webui/grid.js
cp $PROJECT_HOME/web.html.src $PROJECT_HOME/web.html

sed -i "s/PRIVATE_IP_ADDRESS/${PRIVATE_IP_ADDRESS}/" $PROJECT_HOME/Sports/conf/startup.pf
sed -i "s/PRIVATE_IP_ADDRESS/${PRIVATE_IP_ADDRESS}/" $PROJECT_HOME/deploy/conf/runtime.properties
sed -i "s/PUBLIC_IP_ADDRESS/${PUBLIC_IP_ADDRESS}/" $PROJECT_HOME/webui/grid.js
sed -i "s/PUBLIC_IP_ADDRESS/${PUBLIC_IP_ADDRESS}/" $PROJECT_HOME/web.html

cp -f ~/environment/progress.cfg $PROJECT_HOME/oedb/build/license
cp -f ~/environment/progress.cfg $PROJECT_HOME/deploy/license

echo `date +%H:%M:%S`: Building OEDB1 container
cd $PROJECT_HOME/oedb/build
./build.sh 

echo `date +%H:%M:%S`: Running OEDB1 Container
docker run -d -p 20000:20000 -p 3000-3500:3000-3500 -e DB_BROKER_PORT=20000 -e DB_MINPORT=3000 -e DB_MAXPORT=3500 oedb1 2> $ERROR_FILE && echo `date +%H:%M:%S`: Successfully started OEDB1 Container
if [ -s $ERROR_FILE ]
then
    echo `date +%H:%M:%S`: Running OEDB1 Container failed
    cat $ERROR_FILE
fi

echo `date +%H:%M:%S`: Compiling PASOE Sample App
cd $PROJECT_HOME/Sports
proant package
cp $PROJECT_HOME/Sports/output/package-output/Sports.zip $PROJECT_HOME/deploy/ablapps/

echo `date +%H:%M:%S`: Building PASOE Sample App
cd $PROJECT_HOME/deploy
proant package

echo `date +%H:%M:%S`: Deploying PASOE Sample App
cd $PROJECT_HOME/deploy
proant deploy

echo `date +%H:%M:%S`: Deploying NGINX
cd $PROJECT_HOME
docker-compose up -d

echo `date +%H:%M:%S`: Setup Complete
#
