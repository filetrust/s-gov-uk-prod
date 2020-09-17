#!/bin/bash

sudo apt-get update
sudo apt-get install curl git -y

# install docker does not exists
if [ -x "$(command -v docker)" ]; then
    echo "docker exists, skipping installation"
else
    echo "Install docker"
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    sudo curl -L "https://github.com/docker/compose/releases/download/1.27.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    sudo systemctl enable --now docker
    rm get-docker.sh
fi

# get code and deploy
rm -rf /tmp/k8-ova
git clone https://github.com/filetrust/k8-ova.git /tmp/k8-ova
cd /tmp/k8-ova/Release01/
sudo cp  revproxy.tar.gz ~/
cd ~/
sudo tar xzvf revproxy.tar.gz
cd reverse-proxy-icap-docker

# stop docker containers
sudo docker-compose down

# start docker containers
sudo docker-compose up -d

# verify docker container is running
sudo docker-compose ps
