#!/bin/bash


#Create Host File

/var/www/ansible_host/host.sh

# Path to your Python virtual environment
VENV_PATH="/root/python-venv/ansible2.9/"

# Activate the virtual environment
source "${VENV_PATH}/bin/activate"

# Path to your Ansible playbook
#Install Nginx
PLAYBOOK1="/root/python-venv/ansible2.9/nginx_install.yml"

#Open Ports For Https Http and SSH with UFW
PLAYBOOK2="/root/python-venv/ansible2.9/ufw_rules.yml"

#Install .NET
PLAYBOOK3="/root/python-venv/ansible2.9/install_dotnet.yml"


#Install Postgresql 12 
PLAYBOOK4="/root/python-venv/ansible2.9/postgresnew.yml"

#Send  Nginx Confs
PLAYBOOK5="/root/python-venv/ansible2.9/send_nginx_conf_file.yml"


#Create req   Folders
PLAYBOOK6="/root/python-venv/ansible2.9/create_required_folder.yml"


#Sends  Service Files For Project
PLAYBOOK7="/root/python-venv/ansible2.9/send_service.yml"

#Build Project and Send Remote Host
PLAYBOOK8="/root/python-venv/ansible2.9/build_project_and_send.yml"

#Restart All Services
PLAYBOOK9="/root/python-venv/ansible2.9/restart_services.yml"

# Log file path
LOG_FILE="/var/www/ansible.log"


# Run the Ansible playbook and redirect the output to a log file
#Install Nginx
ansible-playbook -i /root/python-venv/ansible2.9/hosts "${PLAYBOOK1}" | tee "${LOG_FILE}"

#Open Ports For Https Http and SSH with UFW
ansible-playbook -i /root/python-venv/ansible2.9/hosts "${PLAYBOOK2}" | tee "${LOG_FILE}"

#Install .NET
ansible-playbook -i /root/python-venv/ansible2.9/hosts "${PLAYBOOK3}" | tee "${LOG_FILE}"

#Install Postgresql 12 and Set Password
ansible-playbook -i /root/python-venv/ansible2.9/hosts "${PLAYBOOK4}" | tee "${LOG_FILE}"


#Send Nginx Conf
ansible-playbook -i /root/python-venv/ansible2.9/hosts "${PLAYBOOK5}" | tee "${LOG_FILE}"

#Create req   Folders
ansible-playbook -i /root/python-venv/ansible2.9/hosts "${PLAYBOOK6}" | tee "${LOG_FILE}"

#Send Service Files For Projects
ansible-playbook -i /root/python-venv/ansible2.9/hosts "${PLAYBOOK7}" | tee "${LOG_FILE}"

#Build Project and Send Remote Host
ansible-playbook -i /root/python-venv/ansible2.9/hosts "${PLAYBOOK8}" | tee "${LOG_FILE}"

#Restart All Services
ansible-playbook -i /root/python-venv/ansible2.9/hosts "${PLAYBOOK9}" | tee "${LOG_FILE}"


#Add Dns Records On DDos_Guard
/var/www/ddos_guard/add_record.sh


#Clean Server Scratch from ZERO
/var/www/full/clean_dir.sh
# Deactivate the virtual environment after running the playbook (optional)
deactivate
