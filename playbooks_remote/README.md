### Ansible Playbooks

The Ansible playbooks perform the following tasks:

1. **nginx_install.yml**: Installs Nginx and configures it for the project.
2. **ufw_rules.yml**: Opens ports for HTTPS, HTTP, and SSH using UFW.
3. **install_dotnet.yml**: Installs the .NET framework.
4. **postgresnew.yml**: Installs PostgreSQL 12 and sets the password.
5. **send_nginx_conf_file.yml**: Sends Nginx configuration files to the server.
6. **create_required_folder.yml**: Creates required folders for the project.
7. **send_service.yml**: Sends service files for the project.
8. **build_project_and_send.yml**: Builds the project and sends it to the remote host.
9. **restart_services.yml**: Restarts all services after deployment.

These scripts and playbooks are essential for deploying and managing APIs for different tenants in a consistent and automated manner.


# These playbooks utilize the following Bash scripts for specific tasks:

- `send_nginx_conf_file.yml` playbook runs the following Bash script to create Nginx configuration files:
  ```bash
  /var/www/ansible/nginx/create_nginx_conf.sh "{{ tenant_id }}" "{{ random_port_merch }}" "{{ random_port_tracker }}"


- `send_service.yml` playbook runs the following Bash script to create service configuration files:
  ```bash
  /var/www/ansible/service/Merch.Tracker.Maker.Apiservice.sh "{{ tenant_id }}" "{{ random_port_merch }}" "{{ random_port_tracker }}"


- `build_project_and_send.yml` playbook runs the following Bash script to build project publish files:
  ```bash
   /var/www/ansible/project/merch_project.sh "{{ tenant_id }}" "{{ media_path }}" "{{ random_port_merch }}"
   /var/www/ansible/project/tracker_project.sh "{{ tenant_id }}"  "{{ random_port_tracker }}"





  
