### RELEASE Candidate 1 AWS CodeDeploy CI/CD Concept

**Create EC2 instance that will be destination server**

- AMI: Ubuntu Server 18.04 LTS (HVM)
- Type: t2.micro
- Auto-assign Public IP: Enable
- User Data:
``` bash
sudo apt-get update
sudo apt-get install -y ruby
sudo apt-get install -y wget
cd /home/ubuntu
wget https://aws-codedeploy-us-east-1.s3.amazonaws.com/latest/install
chmod +x ./install
sudo ./install auto
sudo service codedeploy-agent start
```

- TAG: Name=CodeDeploy
- New Security Group: Open to Public ports 22,80,443
- Key: Select Existing Key that you should be able to login using SSH for debugging purposes.

login to the Ec2 and check 
``` bash
sudo service code deploy-agent status
```

if not actively running run the following:
``` bash
sudo apt-get update
sudo apt-get install -y ruby
sudo apt-get install -y wget
cd /home/ubuntu
wget https://aws-codedeploy-us-east-1.s3.amazonaws.com/latest/install
chmod +x ./install
sudo ./install auto
sudo service codedeploy-agent start
```

**Prepare Developer machine**

Install awscli - https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-linux.html (Linux preferred)

type 'aws configure' and provide all details, e.g.:
``` bash
aws configure
AWS Access Key ID [None]: AK....
AWS Secret Access Key [None]: nb....
Default region name [None]: us-east-1
Default output format [None]: table
```

Clone repository:
``` bash
git clone https://github.com/k8-proxy/s-gov-uk-prod
```

``` bash
cd s-gov-uk-prod/upwork-devs/MariuszFerdyn/v2/
chmod +x reverse-proxy-codedeploy/scripts/*
```

Create Role and notice Arn:
``` bash
aws iam create-role --role-name CodeDeployServiceRole --assume-role-policy-document file://CodeDeployDemo-Trust.json
aws iam attach-role-policy --role-name CodeDeployServiceRole --policy-arn arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole
```

Create Instance Role:

``` bash
aws iam create-role --role-name CodeDeployDemo-EC2-Instance-Profile --assume-role-policy-document file://CodeDeployDemo-EC2-Trust.json
aws iam put-role-policy --role-name CodeDeployDemo-EC2-Instance-Profile --policy-name CodeDeployDemo-EC2-Permissions --policy-document file://CodeDeployDemo-EC2-Permissions.json
aws iam create-instance-profile --instance-profile-name CodeDeployDemo-EC2-Instance-Profile
aws iam add-role-to-instance-profile --instance-profile-name CodeDeployDemo-EC2-Instance-Profile --role-name CodeDeployDemo-EC2-Instance-Profile
```

Assign CodeDeployDemo-EC2-Instance-Profile to the EC2 instance.

``` bash
aws deploy create-application --application-name ReverseProxy_App
```

Create Uniq s3 bucket replacing 1512 to your own:

``` bash
aws s3 mb s3://codedeployrevproxy1512
```

Create Deployment

``` bash
cd reverse-proxy-codedeploy/
aws deploy push --application-name ReverseProxy_App --description "This is a revision for the reverse proxy v01" --ignore-hidden-files --s3-location s3://codedeployrevproxy1512/reverseproxy.zip --source .
aws deploy create-deployment-group --application-name ReverseProxy_App --deployment-config-name CodeDeployDefault.AllAtOnce --deployment-group-name ReverseProxy_DG --ec2-tag-filters Key=Name,Value=CodeDeploy,Type=KEY_AND_VALUE --service-role-arn arn:aws:iam::938576707481:role/CodeDeployServiceRole
aws deploy create-deployment --application-name ReverseProxy_App --s3-location bucket=codedeployrevproxy1512,key=reverseproxy.zip,bundleType=zip --deployment-group-name ReverseProxy_DG  --description "This is a revision for the reverse proxy v01"
```

Deploy new version:

``` bash
aws deploy push --application-name ReverseProxy_App --s3-location s3://codedeployrevproxy1512/reverseproxy.zip --ignore-hidden-files
```

- In the AWS Management Console, on the Services click Code Deploy
- In the left navigation pane, click Applications.
- Click ReverseProxy_App
- Click the Revisions tab.
- Select the revision that has not been deployed yet. This is the latest version.
- Click Deploy application
- On the Create deployment window, configure:
- Deployment group: ReverseProxy_DG
- Scroll to the bottom of the screen, then click Create the deployment
- Wait for the Deployment status to display Succeeded.



**Troubleshooting**

On destination instances:

``` bash
cd /home/user/reverse-proxy-icap-docker/
sudo docker-compose ps
less /var/log/aws/codedeploy-agent/codedeploy-agent.log
```

**To Do**

- use GitHub as a source of deployment (instead of S3)
- use source files instead of revproxy.tar.gz
