#!/bin/bash

if [ "$#" -ne 3 ]; then
    echo "Usage: $0 tenantId random_port_merch random_port_tracker"
    exit 1
fi

# Assign argument to a variable
tenant_id=$1
random_port_merch=$2
random_port_tracker=$3

# Define the service file content with variable substitution
cat << EOF > "/var/www/ansible/service/TrackerMakerApi_${tenant_id}.service"
[Unit]
Description=Tracker MakerApi for Tenant $tenant_id

[Service]
WorkingDirectory=/var/www/Tracker_Maker_Api_${tenant_id}
ExecStart=/usr/bin/dotnet /var/www/Tracker_Maker_Api_${tenant_id}/TrackerMakerApi.dll
Restart=always
RestartSec=10
SyslogIdentifier=tracker-maker-api-$tenant_id
User=root
Environment=ASPNETCORE_ENVIRONMENT=Production
Environment=ASPNETCORE_URLS="http://*:${random_port_tracker}"

[Install]
WantedBy=multi-user.target
EOF


cat << EOF > "/var/www/ansible/service/Merchandising.API_${tenant_id}.service"
[Unit]
Description= Merch Russian Service

[Service]
WorkingDirectory=/var/www/Merchandising_API_${tenant_id}
ExecStart=/usr/bin/dotnet /var/www/Merchandising_API_${tenant_id}/Merchandising.API.dll
Restart=always
RestartSec=10
SyslogIdentifier=${tenant_id}.goagro.ru
User=root
Environment=ASPNETCORE_ENVIRONMENT=Production
Environment=ASPNETCORE_URLS="https://*:${random_port_merch}"

[Install]
WantedBy=multi-user.target


EOF


