# SRE Challenge

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
   1. `terraform init`
   2. `terraform plan -out deployplan`
   3. `terraform apply deployplan`


3. Execute ansible:
   `ansible-playbook -i inventory/webservers.ini playbook.yml`
```
mee@ubuntu:Chandrashekar_Challenge$ ansible-playbook -i inventory/webservers.ini playbook.yml 


PLAY [webserver] ********************************************************************************************************************

TASK [Gathering Facts] **************************************************************************************************************
ok: [10.30.0.023]

TASK [install nginx] ****************************************************************************************************************
ok: [10.30.0.023]

TASK [remove the nginx file] ********************************************************************************************************
ok: [10.30.0.023]

TASK [remove the default nginx file] ************************************************************************************************
changed: [10.30.0.023]

TASK [copy the nginx default file to server] ****************************************************************************************
changed: [10.30.0.023]

TASK [copy the html] ****************************************************************************************************************
ok: [10.30.0.023]

PLAY RECAP **************************************************************************************************************************


10.30.0.023             : ok=6    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0  
```

## Testing

1. test ansible to host connection:
   `ansible webserver -m ping -i inventory/webservers.ini -u ubuntu --private-key ~/.ssh/id_ed25519`

   expected-output:

   ```(shell)
   *.*.*.** | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
   }
   ```
### ToDO:

* add tests using molecule (https://ansible.readthedocs.io/projects/molecule/)