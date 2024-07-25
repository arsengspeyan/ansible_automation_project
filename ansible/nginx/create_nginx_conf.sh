#!/bin/bash



if [ "$#" -ne 3 ]; then
    echo "Usage: $0 tenantId random_port_merch random_port_tracker"
    exit 1
fi

# Assign arguments to variables
tenant_id=$1
random_port_merch=$2
random_port_tracker=$3

json_file="/var/www/ansible/json/ansible_vars_${tenant_id}.json"

if [ ! -f "$json_file" ]; then
    echo "JSON file not found: $json_file"
    exit 1
fi




#merch_sub_domain=$(jq -r '.tenant_id' "$json_file")
#tracker_sub_domain=$(echo "$json_data" | jq -r '.[1].tracker.sub_domain')



cat <<EOF > /var/www/ansible/nginx/Merchandising.API.Prod_${tenant_id}.conf
server{

        listen  80;
        server_name ${tenant_id}-merchapi.spectrepro.ru;
        return 301 https://\$server_name\$request_uri;
      }

server {
    listen       443 ssl;
    server_name  ${tenant_id}-merchapi.spectrepro.ru;

        ssl_certificate          /etc/nginx/conf.d/certs_client/merch.crt;
        ssl_certificate_key     /etc/nginx/conf.d/certs_client/merch.key;



        location /{

                proxy_set_header X-Forwarded-For \$remote_addr;
                proxy_set_header Host \$http_host;
                proxy_pass http://127.0.0.1:${random_port_merch};

        }
        access_log    /var/log/nginx/${tenant_id}_Merch.Admin.Api.access.log;
        error_log    /var/log/nginx/${tenant_id}_Merch.Admin.Api.error.log;
}
EOF

cat <<EOF > /var/www/ansible/nginx/Merch.Tracker.Maker.Api.Prod_${tenant_id}.conf 
server{

        listen  80;
        server_name ${tenant_id}-merchtrackerapi.spectrepro.ru;
        return 301 https://\$server_name\$request_uri;
      }

server {
    listen       443 ssl;
    server_name  ${tenant_id}-merchtrackerapi.spectrepro.ru;

        ssl_certificate          /etc/nginx/conf.d/certs_client/merch.crt;
        ssl_certificate_key     /etc/nginx/conf.d/certs_client/merch.key;



        location /{

                proxy_set_header X-Forwarded-For  \$remote_addr;
                proxy_set_header Host \$http_host;
                proxy_pass http://127.0.0.1:${random_port_tracker};

        }
        access_log    /var/log/nginx/${tenant_id}_Tracker.Api.access.log;
        error_log    /var/log/nginx/${tenant_id}_Tracker.Api.error.log;
}
EOF
