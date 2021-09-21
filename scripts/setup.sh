#!/bin/sh

export PROJECT_HOME=~/pasoe-sample-app
export DLC=/psc/dlc
export PATH=$DLC/bin:$PATH

docker login
sudo yum -y install htop jq
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

cd
git clone  --recurse-submodules https://github.com/aws-quickstart/quickstart-progress-openedge.git

export PUBLIC_IP_ADDRESS=`aws ec2 describe-instances | jq -r '.Reservations[].Instances[] | select(.State.Name == "running" and .Tags[].Value == "dev1") | .PublicIpAddress'`
export PRIVATE_IP_ADDRESS=`aws ec2 describe-instances | jq -r '.Reservations[].Instances[] | select(.State.Name == "running" and .Tags[].Value == "dev1") | .PrivateIpAddress'`

sed -i "s/PRIVATE_IP_ADDRESS/${PRIVATE_IP_ADDRESS}/" $PROJECT_HOME/Sports/conf/startup.pf
sed -i "s/PRIVATE_IP_ADDRESS/${PRIVATE_IP_ADDRESS}/" $PROJECT_HOME/deploy/conf/runtime.properties
sed -i "s/PUBLIC_IP_ADDRESS/${PUBLIC_IP_ADDRESS}/" $PROJECT_HOME/webui/grid.js

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

cp -f /psc/dlc/progress.cfg $PROJECT_HOME/oedb/build/license
cp -f /psc/dlc/progress.cfg $PROJECT_HOME/deploy/license

cd $PROJECT_HOME/oedb/build
./build.sh

docker run -d -p 20000:20000 -p 3000-3500:3000-3500 -e DB_BROKER_PORT=20000 -e DB_MINPORT=3000 -e DB_MAXPORT=3500 oedb1

cd $PROJECT_HOME/Sports
proant package
cp $PROJECT_HOME/Sports/output/package-output/Sports.zip $PROJECT_HOME/deploy/ablapps/

cd $PROJECT_HOME/deploy
proant deploy

cd $PROJECT_HOME
docker-compose up -d 
#
