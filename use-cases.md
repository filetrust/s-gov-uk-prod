# Introduction

Github Actions in this repository can be reused to deploy infrastructure to AWS
and deploy applications to remote virtual machines such as AWS EC2 or Azure virtual machines.

## The workflows can be reused and extended for following use cases:

1. [Deploy infrastructure to AWS](https://github.com/pranaysahith/s-gov-uk-prod/blob/master/use-cases.md#1-deploy-infrastructure-to-aws)
2. Delete infrastructure from AWS 
3. Deploy an application to a virtual machine
4. Re-deploy an application to a virtual machine
5. Stop EC2 virtual machines at a scheduled time

## 1. Deploy infrastructure to AWS 
The infrastructure as code is written using terraform and located at `infrastructure/terraform` directory in this repo. It uses remote S3 backend to store state and hence deployments can be done iteratively to add more resources.

To configure authentication and to pass variable values to terraform we need to setup secrets in github and the secret values can be securely accessed from github workflow using `${{ secrets.SECRET_NAME }}` 

Executing the workflow:

1. The workflow can be set to be triggered automatically on code push to master branch.
2. The workflow can be setup to trigger only manually to disable continuous deployment.

## 2. Delete infrastructure from AWS 
The infrastructure can be deleted from AWS when needed using "Destroy Infra" workflow. This workflow uses the same terraform backend used by deployment workflow and hence it can delete all the resources deployed by above workflow.

Executing the workflow:

1. The workflow has been setup to run manually so that we can delete the infrastructure only when we need. There will not be any triggers for this workflow.


## 3. Deploy an application to a virtual machine
Applications are deployed to virtual machines by connecting through ssh and running deployment scripts on the virtual machines. The deployment scripts can be written so that required dependencies should be installed first, then stop the application if it is already running and then deploy and start the application. scp is used to securely copy files from git to the virtual machines. 

Details required to connect to virtual machines such as hostname, username, password/private key must be placed in github secrets and access them securely from the workflow.

To make sure the virtual machines can be connected from the github workflow, security groups of the virtual machines should allow ssh access from github runners IP address ranges.

The applications can be anything like web servers, docker containers, k8s applications etc.

## 4. Re-deploy an application to a virtual machine
The applications can be re-deployed to virtual machines by configuring push triggers on master branch. The trigger will enable continuous deployment of code to virtual machines as soon as it lands in master branch.

The deployment scripts should be written in such a way, so that it first checks if the required dependencies are already installed on the VMs and install the dependencies only when they are not present. 

The script should stop a running application and start the application with the new code.


## 5. Stop EC2 virtual machines at a scheduled time
The workflows can be scheduled to run at a periodic time intervals similar to cron jobs. By integrating aws cli commands in the workflow, the EC2 virtual machines can be stopped at a given time everyday.
