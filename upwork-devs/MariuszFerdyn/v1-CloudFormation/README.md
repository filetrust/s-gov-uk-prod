### RELEASE Candidate 1 CloudFormation 


AWS CloudFormation script that deploys container from https://github.com/filetrust/k8-ova/tree/master/Release01/ to:
- VPC
- One subnet
- EC2 instance with up and running https://github.com/filetrust/k8-ova/tree/master/Release01/revproxy.tar.gz 
- internet gateway
- NAT gateway
- one EIP


This template is to designed to work in all regions but it requires two input parameters:
- EC2 ssh access key
- AMI ID for Ubuntu 18"

**To Do**

- This can be part of creating CI/CD process. Just code build must modify this cloud/formation script and run it.

**How to check if is it working**

- connect using SSH to the instances

``` bash
cd /home/user/reverse-proxy-icap-docker/
 sudo docker-compose ps
```

make sure everything is up.
