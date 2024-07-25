#!/bin/bash


# Function to generate a random port number
generate_random_port_merch() {
    echo $(( ( RANDOM % 5000 )  + 5000 ))  # Adjust the range of random port numbers as needed
}

generate_random_port_tracker() {
    echo $(( ( RANDOM % 5000 )  + 5000 ))  # Adjust the range of random port numbers as needed
}


# Generate a random port number
random_port_merch=$(generate_random_port_merch)
random_port_tracker=$(generate_random_port_tracker)

# Check if the required number of arguments are provided
if [ "$#" -ne 5 ]; then
    echo "Usage: $0 tenantId serverRealIP serverUser serverPassword mediaPath"
    exit 1
fi

# Assign arguments to variables
tenant_id=$1
server_real_ip=$2
server_user=$3
server_password=$4
media_path=$5

# Create JSON file with the provided parameters
cat <<EOF > "/var/www/ansible/json/ansible_vars_${tenant_id}.json"
{
    "tenant_id": "$tenant_id",
    "server_real_ip": "$server_real_ip",
    "server_user": "$server_user",
    "server_password": "$server_password",
    "media_path": "$media_path"
}
EOF

/var/www/ansible/ansible_host/host.sh "${tenant_id}"

# Path to your Python virtual environment
VENV_PATH="/root/python-venv/ansible2.9/"

# Activate the virtual environment
source "${VENV_PATH}/bin/activate"


# Path to your Ansible playbook
#Install Nginx
PLAYBOOK1="/root/python-venv/ansible2.9/playbooks_remote/nginx_install.yml"


#Open Ports For Https Http and SSH with UFW
PLAYBOOK2="/root/python-venv/ansible2.9/playbooks_remote/ufw_rules.yml"


#Install .NET
PLAYBOOK3="/root/python-venv/ansible2.9/playbooks_remote/install_dotnet.yml"


#Install Postgresql 12 
PLAYBOOK4="/root/python-venv/ansible2.9/playbooks_remote/postgresnew.yml"


#Send  Nginx Confs
PLAYBOOK5="/root/python-venv/ansible2.9/playbooks_remote/send_nginx_conf_file.yml"


#Create req   Folders
PLAYBOOK6="/root/python-venv/ansible2.9/playbooks_remote/create_required_folder.yml"


#Sends  Service Files For Project
PLAYBOOK7="/root/python-venv/ansible2.9/playbooks_remote/send_service.yml"


#Build Project and Send Remote Host
PLAYBOOK8="/root/python-venv/ansible2.9/playbooks_remote/build_project_and_send.yml"


#Restart All Services
PLAYBOOK9="/root/python-venv/ansible2.9/playbooks_remote/restart_services.yml"


# Log file path
LOG_FILE="/var/www/ansible.log"




# 1 Run the Ansible playbook and redirect the output to a log file
#Install Nginx
ansible-playbook -i /root/python-venv/ansible2.9/hosts_${tenant_id} "${PLAYBOOK1}" | tee "${LOG_FILE}"

# 2 Open Ports For Https Http and SSH with UFW
ansible-playbook -i /root/python-venv/ansible2.9/hosts_${tenant_id} "${PLAYBOOK2}" | tee "${LOG_FILE}"


# 3 Install .NET
ansible-playbook -i /root/python-venv/ansible2.9/hosts_${tenant_id} "${PLAYBOOK3}" | tee "${LOG_FILE}"


# 4 Install Postgresql 12 and Set Password
#ansible-playbook -i /root/python-venv/ansible2.9/hosts_${tenant_id} "${PLAYBOOK4}" | tee "${LOG_FILE}"


# 5 Send Nginx Conf
ansible-playbook -i /root/python-venv/ansible2.9/hosts_${tenant_id} "${PLAYBOOK5}"  --extra-vars "tenant_id=${tenant_id} random_port_merch=${random_port_merch} random_port_tracker=${random_port_tracker}" | tee "${LOG_FILE}"

# 6 Create req   Folders
ansible-playbook -i /root/python-venv/ansible2.9/hosts_${tenant_id} "${PLAYBOOK6}"  --extra-vars "tenant_id=${tenant_id} media_path=${media_path}" | tee "${LOG_FILE}"


# 7 Send Service Files For Projects
ansible-playbook -i /root/python-venv/ansible2.9/hosts_${tenant_id} "${PLAYBOOK7}"  --extra-vars "tenant_id=${tenant_id} random_port_merch=${random_port_merch} random_port_tracker=${random_port_tracker}" | tee "${LOG_FILE}"


# 8 Build Project and Send Remote Host
ansible-playbook -i /root/python-venv/ansible2.9/hosts_${tenant_id} "${PLAYBOOK8}" --extra-vars "tenant_id=${tenant_id} media_path=${media_path} random_port_merch=${random_port_merch} random_port_tracker=${random_port_tracker}" | tee "${LOG_FILE}"


# 9 Restart All Services
ansible-playbook -i /root/python-venv/ansible2.9/hosts_${tenant_id} "${PLAYBOOK9}" --extra-vars "tenant_id=${tenant_id}" | tee "${LOG_FILE}"


#Add Dns Records On DDos_Guard
/var/www/ansible/cloudflare/add_record.sh "${tenant_id}" 

#POST tenatid

/var/www/ansible/cloudflare/post_tenatid.sh "${tenant_id}"

# Clean Server Scratch from ZERO
#/var/www/ansible/full/clean_dir.sh "${tenant_id}"

# Deactivate the virtual environment after running the playbook (optional)
deactivate

# Clean Server Scratch from ZERO
/var/www/ansible/cleandir/clean_dir.sh "${tenant_id}"


#POST tenant_id
/var/www/ansible/cloudflare/post_tenatid.sh "${tenant_id}"

