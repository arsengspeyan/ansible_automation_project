## Description

This project includes a shell scripts,which is in separate files

### Shell Script

The shell script is responsible for:

- Generating random port numbers for different services.
- Creating a JSON file with provided parameters (tenant ID, server details, media path).
- Activating a Python virtual environment.
- Running Ansible playbooks to install and configure various components such as Nginx, UFW rules, .NET, PostgreSQL, and more.
- Adding DNS records using Cloudflare
- Cleaning all created directories and files locally.
- Notify an API endpoint about the completion of a Bash script, providing the tenantId as a parameter.


#The realtest.sh script located at /var/www/ansible/prod_remote/realtest.sh is the main script responsible for running all jobs and automation tasks in your project.






