#!/bin/bash


if [ "$#" -ne 1 ]; then
    echo "Usage: $0 tenantId"
    exit 1
fi


# Define the parameters
tenant_id=$1


# Define the URL
url="https://merchmanagementapi.spectrepro.ru/api/devops-communication/bash-script-finished?tenantid=$tenant_id"

# Define the API key
api_key="WRceOuF30TGwZx7CrWQEKoS3MguFvdcBQZsT8pRdKWMuvRE0FcUIJIbyRiTKqdmo"


response=$(curl -X POST \
    -H "Content-Type: application/json" \
    -H "ApiKey: $api_key" \
    -d "{\"tenantid\": \"$tenant_id\"}" \
    "$url")
# Print the response
echo "Response: $response"

