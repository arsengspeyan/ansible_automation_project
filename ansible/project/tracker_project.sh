#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 tenantId random_port_tracker"
    exit 1
fi

# Assign arguments to variables
tenant_id=$1
random_port_tracker=$2



# Define variables
REPO_URL="<repository>"
CLONE_DIR="/var/www/ansible/project/Clone_Dir_Tracker_${tenant_id}"
BUILD_DIR="$CLONE_DIR/TrackerMakerApi"

# Clone the Git project
echo "Cloning the Git project..."
git clone --branch for_automation_server "$REPO_URL" "$CLONE_DIR"

# Check if the clone was successful
if [ $? -eq 0 ]; then
    echo "Git clone successful."
else
    echo "Failed to clone the Git project. Exiting."
    exit 1
fi

# Change directory to the Merchandising_Api directory
echo "Changing directory to Merchandising_Api..."
cd "$BUILD_DIR" || exit

# Build the project
echo "Building the project..."
dotnet build -c Release

# Check if build is successful
if [ $? -eq 0 ]; then
    echo "Build successful."
else
    echo "Build failed. Exiting."
    exit 1
fi

# Publish the project
echo "Publishing the project..."
dotnet publish -c Release --no-build 

# Check if publish is successful
if [ $? -eq 0 ]; then
    echo "Publish successful."
else
    echo "Publish failed. Exiting."
    exit 1
fi



cd ${BUILD_DIR}/bin/Release/net6.0/publish/

sed -i "s/Database=tracker_maker_prod/Database=tracker_maker_prod_${tenant_id}/g" appsettings.json

sed -i -e "s#\"Url\": \"http://localhost:[0-9]\+\"#\"Url\": \"http://localhost:${random_port_tracker}\"#g" appsettings.json

sed -i "s|\"TrackingTokenUrl\": \"https://trackermakerapidev.innline.am/api/client/get-token\"|\"TrackingTokenUrl\": \"https://${tenant_id}-merchtrackerapi.spectrepro.ru/api/client/get-token\"|g" appsettings.json

 

 



# End of script
