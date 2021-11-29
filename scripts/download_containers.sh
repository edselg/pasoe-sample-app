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
docker pull store/progresssoftware/pasoe:12.3.0
docker pull store/progresssoftware/oedb:12.3.0_ent
docker pull adoptopenjdk:11.0.4_11-jdk-hotspot
echo `date +%H:%M:%S`: Setup Complete
#
