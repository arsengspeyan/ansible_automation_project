#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 tenantId"
    exit 1
fi

# Assign arguments to variables
tenant_id=$1



json_file="/var/www/ansible/json/ansible_vars_${tenant_id}.json"

#if [ ! -f "$json_file" ]; then
#    echo "JSON file not found: $json_file"
#    exit 1
#fi


#server_ip=$(echo "$json_data" | jq -r '.server.server_ip')
#server_user=$(echo "$json_data" | jq -r '.server.server_user')
#server_password=$(echo "$json_data" | jq -r '.server.server_password')
server_ip=$(jq -r '.server_real_ip' "$json_file")
server_user=$(jq -r '.server_user' "$json_file")
server_password=$(jq -r '.server_password' "$json_file")


HOST=${server_ip}

# Use ssh-keyscan to retrieve the SSH host key and add it to the known_hosts file
ssh-keyscan -H "${HOST}" >> ~/.ssh/known_hosts




cat <<EOF > /root/python-venv/ansible2.9/hosts_${tenant_id}

server1 ansible_host=${server_ip} ansible_user=${server_user} ansible_ssh_pass=${server_password}

EOF

