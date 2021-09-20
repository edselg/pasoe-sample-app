#!/bin/sh

export DLC=/psc/dlc
export PATH=$DLC/bin:$PATH

export PRIVATE_IP_ADDRESS=`aws ec2 describe-instances | jq -r '.Reservations[].Instances[] | select(.State.Name == "running" and .Tags[].Value == "dev1") | .PrivateIpAddress'`

sed -i "s/PRIVATE_IP_ADDRESS/${PRIVATE_IP_ADDRESS}/" ~/pasoe-sample-app/Sports/conf/startup.pf

#cd ~/pasoe-sample-app/oedb/build
#./build.sh

cd ~/pasoe-sample-app/Sports
proant package
cp ~/pasoe-sample-app/Sports/output/package-output/Sports.zip ~/pasoe-sample-app/deploy/ablapps/
