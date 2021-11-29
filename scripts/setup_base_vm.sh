#!/bin/sh

echo `date +%H:%M:%S`: Setup Begin
export TERM=vt100
export PROJECT_HOME=~/environment/pasoe-sample-app
export DLC=/psc/dlc
export PATH=$DLC/bin:$PATH
export ERROR_FILE=/tmp/errors.$$

echo `date +%H:%M:%S`: Installing Packages
sudo yum -y install htop gcc jq

if [ ! -d /usr/lib/jvm/java-11-amazon-corretto.x86_64 ]
then
    echo `date +%H:%M:%S`: Installing Amazon Corretto
    sudo yum -y install java-11-amazon-corretto
fi
if [ ! -d /usr/lib/jvm/jdk ]
then
    sudo ln -s /usr/lib/jvm/java-11-amazon-corretto.x86_64 /usr/lib/jvm/jdk
fi

if [ ! -d ~/.nvm ]
then
    echo `date +%H:%M:%S`: Installing NVM
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
fi
. ~/.nvm/nvm.sh

if [ ! -f /home/ec2-user/.nvm/versions/node/v17.1.0/bin/node ]
then
    echo `date +%H:%M:%S`: Installing Node.js
    nvm install node
fi

if [ ! -d ~/.c9 ]
then
    echo `date +%H:%M:%S`: Installing Cloud9 Support
    curl -L https://raw.githubusercontent.com/c9/install/master/install.sh | bash
fi

if [ ! -f /usr/bin/docker ]
then
    echo `date +%H:%M:%S`: Installing Docker
    sudo amazon-linux-extras install docker
    sudo systemctl enable docker
    sudo systemctl start docker
    sudo usermod -aG docker $USER
fi
if [ ! -f /usr/local/bin/docker-compose ]
then
    echo `date +%H:%M:%S`: Installing Docker Compose
    sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
fi

if [ ! -d /psc ]
then
    if [ ! -f /home/ec2-user/install/12.3.0.tar.gz ]
    then
        echo `date +%H:%M:%S`: Downloading OpenEdge 12.3.0
        mkdir -p ~/install        
        aws s3 cp s3://mysupportfiles2/12.3.0.tar.gz ~/install
        tar xzvCf ~/install ~/install/12.3.0.tar.gz
        rm ~/install/12.3.0.tar.gz    
    fi
    echo `date +%H:%M:%S`: Installing OpenEdge 12.3.0
    sudo /home/ec2-user/install/12.3.0/proinst -b /home/ec2-user/install/12.3.0/response_oedev.ini -l /tmp/output.log && rm -rf ~/install/12.3.0
fi

echo `date +%H:%M:%S`: Setup Complete
exit
