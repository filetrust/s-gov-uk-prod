#!/bin/bash
curl https://get.docker.com -o /tmp/docker-installer.sh
chmod +x /tmp/docker-installer.sh
sudo /tmp/docker-installer.sh
sudo systemctl enable --now docker
sudo useradd -m -p $6$GZT5nssfvanFhk/q$w0R3RBjN4CP2uSLSqVRlRDDkrJbrXLDFwIQfVsH678PHQCIqXtZG3Q7SyBq1J5RRRekuFGZ2xWOMOyyx2PoEt0 -s /bin/bash user
sudo usermod -aG docker ubuntu
sudo usermod -aG docker user
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose