#!/bin/bash
#sudo /bin/cp -rf /opt/reverse-proxy/revproxy.tar.gz /home/user/
#cd /home/user/
cd /opt/reverse-proxy/upwork-devs/MariuszFerdyn/v3-CodeDeploy/reverse-proxy-codedeploy/reverse-proxy-icap-docker
chmod 755 /opt/reverse-proxy/upwork-devs/MariuszFerdyn/v3-CodeDeploy/reverse-proxy-codedeploy/reverse-proxy-icap-docker/nginx/entrypoint.sh
chmod 755 /opt/reverse-proxy/upwork-devs/MariuszFerdyn/v3-CodeDeploy/reverse-proxy-codedeploy/reverse-proxy-icap-docker/squid/entrypoint.sh
echo 'secret' | sudo -S -E su user -c 'docker-compose up -d'