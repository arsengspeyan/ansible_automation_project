# Introduction 
 This project aims to automate the deployment of APIs for different tenants using Ansible playbooks and Bash scripts. The main objective is to streamline the process of deploying and managing APIs, reducing manual effort and ensuring consistency across deployments.

# Getting Started

#Installation Process
To get started with the project, follow these steps:

1.Clone the repository:
git clone https://innline@dev.azure.com/innline/DevOps/_git/automation_project_Merchandising

2.Update and install Python 3:

sudo yum update

sudo yum install python3

python3 --version

python3

#create virtual environment

python3 -V

mkdir python-venv

cd !$

python3 -m venv ansible2.9

#Activate a Python virtual environment

source ansible2.9/bin/activate

python3 -V

python3 -m pip install --upgrade pip

Install Ansible in a virtual environment

python3 -m pip install ansible==2.9

which ansible

ansible --version

#Software Dependencies
This project relies on the following software dependencies:

python3

Ansible

Bash


# Build and Test
./var/www/ansible/prod_remote/realtest.sh
