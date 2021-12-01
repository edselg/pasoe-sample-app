#!/bin/sh

export TERM=vt100
export PROJECT_HOME=~/environment/pasoe-sample-app
export PATH=$DLC/bin:$PATH
export ERROR_FILE=/tmp/errors.$$

echo `date +%H:%M:%S`: Setup Begin
docker login
echo `date +%H:%M:%S`: Downloading Containers
docker pull alpine:3.8
docker pull nginx:latest
# docker pull store/progresssoftware/pasoe:12.3.0
# docker pull store/progresssoftware/oedb:12.3.0_ent
docker pull adoptopenjdk:11.0.4_11-jdk-hotspot

aws s3 cp s3://mysupportfiles2/PROGRESS_OE_DATABASE_CONTAINER_IMAGES_12.5.0_LNX_64.zip ~/install/tmp/
aws s3 cp s3://mysupportfiles2/PROGRESS_PASOE_CONTAINER_IMAGE_12.5.0_LNX_64.zip ~/install/tmp/

unzip ~/install/tmp/PROGRESS_OE_DATABASE_CONTAINER_IMAGES_12.5.0_LNX_64.zip -d ~/install/tmp/ *.gz
unzip ~/install/tmp/PROGRESS_PASOE_CONTAINER_IMAGE_12.5.0_LNX_64.zip -d ~/install/tmp/ *.gz

docker load -i ~/install/tmp/PROGRESS_OE_DATABASE_CONTAINER_IMAGE_12.5.0_LNX_64.tar.gz
docker load -i ~/install/tmp/PROGRESS_PASOE_CONTAINER_IMAGE_12.5.0_LNX_64.tar.gz

rm -rf ~/install/tmp

echo `date +%H:%M:%S`: Setup Complete
#
