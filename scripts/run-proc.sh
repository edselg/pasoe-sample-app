#!/bin/sh

export PROJECT_HOME=~/environment/pasoe-sample-app
export DLC=/psc/dlc
export PATH=$DLC/bin:$PATH
export display_banner=no

cd `dirname $1`  
pro -b -p $1 > /tmp/output.$$
cat /tmp/output.$$
exit

export PUBLIC_IP_ADDRESS=`aws ec2 describe-instances | jq -r '.Reservations[].Instances[] | select(.State.Name == "running" and .Tags[].Value == "dev1") | .PublicIpAddress'`
export PRIVATE_IP_ADDRESS=`aws ec2 describe-instances | jq -r '.Reservations[].Instances[] | select(.State.Name == "running" and .Tags[].Value == "dev1") | .PrivateIpAddress'`

cp $PROJECT_HOME/Sports/conf/startup.pf.bk $PROJECT_HOME/Sports/conf/startup.pf
cp $PROJECT_HOME/deploy/conf/runtime.properties.bk $PROJECT_HOME/deploy/conf/runtime.properties
cp $PROJECT_HOME/webui/grid.js.bk $PROJECT_HOME/webui/grid.js
cp $PROJECT_HOME/web.html.bk $PROJECT_HOME/web.html
sed -i "s/PRIVATE_IP_ADDRESS/${PRIVATE_IP_ADDRESS}/" $PROJECT_HOME/Sports/conf/startup.pf
sed -i "s/PRIVATE_IP_ADDRESS/${PRIVATE_IP_ADDRESS}/" $PROJECT_HOME/deploy/conf/runtime.properties
sed -i "s/PUBLIC_IP_ADDRESS/${PUBLIC_IP_ADDRESS}/" $PROJECT_HOME/webui/grid.js
sed -i "s/PUBLIC_IP_ADDRESS/${PUBLIC_IP_ADDRESS}/" $PROJECT_HOME/web.html

docker kill oedb1
docker rm oedb1
docker run --name oedb1 -d -p 20000:20000 -p 3000-3200:3000-3200 -e DB_BROKER_PORT=20000 -e DB_MINPORT=3000 -e DB_MAXPORT=3200 oedb1

cd $PROJECT_HOME/deploy
proant undeploy
proant deploy

cd $PROJECT_HOME
docker-compose down
docker-compose up -d
