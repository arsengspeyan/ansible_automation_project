#!/bin/bash



if [ "$#" -ne 1 ]; then
    echo "Usage: $0 tenantId"
    exit 1
fi

# Assign arguments to variables
tenant_id=$1



json_file="/var/www/ansible/json/ansible_vars_${tenant_id}.json"

if [ ! -f "$json_file" ]; then
    echo "JSON file not found: $json_file"
    exit 1
fi


tenant_id=$(jq -r '.tenant_id' "$json_file")
server_real_ip=$(jq -r '.server_real_ip' "$json_file")

#merch_sub_domain=$(echo "$json_data" | jq -r '.[0].merch.sub_domain')
#tracker_sub_domain=$(echo "$json_data" | jq -r '.[1].tracker.sub_domain')
#server_ip=$(echo "$json_data" | jq -r '.[2].server.server_ip')


curl --request POST   --url https://api.cloudflare.com/client/v4/zones/1e41192ee191ceff1631da2009546aca/dns_records   --header 'Content-Type: application/json'   --header 'X-Auth-Email: spectrepro@goagro.ru '   --header 'X-Auth-Key: cb8bde711a61ecf90d08d7369963230a7dd98'   --data '{
  "content": "'"${server_real_ip}"'",
  "name": "'"${tenant_id}-merchapi.spectrepro.ru"'",
  "proxied": true,
  "type": "A",
  "comment": "Domain verification record",
  "ttl": 3600
}'

curl --request POST   --url https://api.cloudflare.com/client/v4/zones/1e41192ee191ceff1631da2009546aca/dns_records   --header 'Content-Type: application/json'   --header 'X-Auth-Email: spectrepro@goagro.ru '   --header 'X-Auth-Key: cb8bde711a61ecf90d08d7369963230a7dd98'   --data '{
  "content": "'"${server_real_ip}"'",
  "name": "'"${tenant_id}-merchtrackerapi.spectrepro.ru"'",
  "proxied": true,
  "type": "A",
  "comment": "Domain verification record",
  "ttl": 3600
}'



