#!/bin/sh

export PROJECT_HOME=~/environment/pasoe-sample-app
export DLC=/psc/dlc
export PATH=$DLC/bin:$PATH
export DOCKER_BUILDKIT=1

export PRIVATE_IP_ADDRESS=`aws ec2 describe-instances | jq -r '.Reservations[].Instances[] | select(.State.Name == "running" and .Tags[].Value == "dev1") | .PrivateIpAddress'`

sed -i "s/PRIVATE_IP_ADDRESS/${PRIVATE_IP_ADDRESS}/" $PROJECT_HOME/Sports/conf/startup.pf

#cd $PROJECT_HOME/oedb/build
#./build.sh

cd $PROJECT_HOME/Sports
proant package
cp $PROJECT_HOME/Sports/output/package-output/Sports.zip $PROJECT_HOME/deploy/ablapps/

cd $PROJECT_HOME/deploy
proant package
