#!/bin/sh
  
export DLC=/psc/dlc
export PATH=$DLC/bin:$PATH

export PUBLIC_IP_ADDRESS=`aws ec2 describe-instances | jq -r '.Reservations[].Instances[] | select(.State.Name == "running" and .Tags[].Value == "dev1") | .PublicIpAddress'`
export PRIVATE_IP_ADDRESS=`aws ec2 describe-instances | jq -r '.Reservations[].Instances[] | select(.State.Name == "running" and .Tags[].Value == "dev1") | .PrivateIpAddress'`

sed -i "s/PRIVATE_IP_ADDRESS/${PRIVATE_IP_ADDRESS}/" ~/pasoe-sample-app/Sports/conf/startup.pf
sed -i "s/PRIVATE_IP_ADDRESS/${PRIVATE_IP_ADDRESS}/" ~/pasoe-sample-app/deploy/conf/runtime.properties
sed -i "s/PUBLIC_IP_ADDRESS/${PUBLIC_IP_ADDRESS}/" ~/pasoe-sample-app/webui/grid.js

docker kill oedb1
docker rm oedb1
docker run --name oedb1 -d -p 20000:20000 -p 3000-3200:3000-3200 -e DB_BROKER_PORT=20000 -e DB_MINPORT=3000 -e DB_MAXPORT=3200 oedb1

cd ~/pasoe-sample-app/deploy
proant undeploy
proant deploy

cd ~/pasoe-sample-app
docker-compose down
docker-compose up -d
