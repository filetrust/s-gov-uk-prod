# s-gov-uk-prod

## Add below secrets to the Github secrets:

### Infra secrets:

1. INSTANCE_TYPE   - Instance type to use
2. INBOUND_CIDR    - CIDR to allow traffic from
3. VPC_ID          - VPC ID in which EC2 should be deployed
4. SUBNET_ID       - Subnet ID in which EC2 should be deployed
5. ELASTIC_IP_NAME - Elastic IP name to be used by EC2 for static IP
6. KEY_NAME        - Key name to be used for EC2
7. BACKEND_BUCKET  - S3 bucket name to store terraform backend

### Application secrets:

1. HOST - IP address or domain name of the VM
2. PORT - SSH port number
3. USERNAME - username to login
4. EC2_AUTH - Private key to authenticate to VM

## Once the code is merged to master branch, reverse proxy solution will be deployed to the server.

## Deploy infra to AWS

1. To deploy infrastructure(EC2) to AWS, run the workflow named "Deploy Infra to AWS"
2. It accepts input value for "action" and its default value is "plan". 
3. If "plan" is passed as input, it will only plan and print the `terraform plan` output
4. If "apply" is passed as the input, it will deploy the infrastructure to the AWS.
5. As the EC2 need to use a static IP for the VM, an elastic IP should be created in AWS and the name should be passed as variable.

## Destroy infra from AWS

1. To delete the infrastructure from AWS, run the workflow named "Destroy Infra"
2. It accepts input value for "action" and its default value is "plan"/
3. If "plan" is passed as input, it will only plan the destroy and print the `terraform plan -destroy` output
4. If "destroy" is passed as the input, it will delete the infrastructure from the AWS.

