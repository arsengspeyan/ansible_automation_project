#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 tenantId"
    exit 1
fi


# Define the parameters
tenant_id=$1



# Define the directories and files to delete
directories=(
    "/var/www/ansible/project/Clone_Dir_Merch_${tenant_id}"
    "/var/www/ansible/project/Clone_Dir_Tracker_${tenant_id}"
)

files=(
    "/var/www/ansible/nginx/Merchandising.API.Prod_${tenant_id}.conf"
    "/var/www/ansible/nginx/Merch.Tracker.Maker.Api.Prod_${tenant_id}.conf"
    "/var/www/ansible/service/Merchandising.API_${tenant_id}.service"
    "/var/www/ansible/service/TrackerMakerApi_${tenant_id}.service"
    "/var/www/ansible/json/ansible_vars_${tenant_id}.json"
    "/var/www/ansible/ansible_host/hosts_${tenant_id}"
)

# Function to delete directories
delete_directories() {
    for dir in "${directories[@]}"; do
        if [ -d "$dir" ]; then
            echo "Deleting directory: $dir"
            rm -rf "$dir"
            echo "Directory deleted successfully."
        else
            echo "Directory does not exist: $dir"
        fi
    done
}

# Function to delete files
delete_files() {
    for file in "${files[@]}"; do
        if [ -f "$file" ]; then
            echo "Deleting file: $file"
            rm -f "$file"
            echo "File deleted successfully."
        else
            echo "File does not exist: $file"
        fi
    done
}

# Main function
main() {
    delete_directories
    delete_files
}

# Run the main function
main

