#!/bin/bash
sudo /bin/cp -rf /opt/reverse-proxy/revproxy.tar.gz /home/user/
cd /home/user/
sudo tar xzvf revproxy.tar.gz
cd reverse-proxy-icap-docker
echo 'secret' | sudo -S -E su user -c 'docker-compose up -d'