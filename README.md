## SRE Challange

* Website deploy
* Code challenges

## Setup

1. Download and install:
   1. [Terraform](https://developer.hashicorp.com/terraform/downloads)
   2. [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

2. Create IAM user keys and ssh-key setup
   1. ssh-setup:
      1. ssh-keygen -t rsa -b 4096
   2. Download IAM user Access keys, make sure to have PowerUser Policy attached
      1. `aws configure`
      2. verify with `aws sts get-caller-identity`

## Deployment
1. change values in the variables file and refresh setup
2. run the following to create webserver
   1. `terraform init` - download plugins, providers and refresh/setup state in s3
   2. `terraform plan -out deployplan` - generate dependecy graph and plan to create/update/delete resources
   3. `terraform apply deployplan` - deploy the changes/requests based on the plan file supplied and statefile configured