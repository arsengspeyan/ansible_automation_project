#!/bin/bash



if [ "$#" -ne 3 ]; then
    echo "Usage: $0 tenantId media_path random_port_merch"
    exit 1
fi

# Assign arguments to variables
tenant_id=$1
media_path=$2
random_port_merch=$3

echo ${media_path}


# Define variables
REPO_URL="<repository>"
CLONE_DIR="/var/www/ansible/project/Clone_Dir_Merch_${tenant_id}"
BUILD_DIR="$CLONE_DIR/Merchandising.API"

# Clone the Git project
echo "Cloning the Git project..."
git clone --branch main "$REPO_URL" "$CLONE_DIR"

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

sed -i "s/Database=merchandising_db_prod_v2/Database=merchandising_db_prod_v2_${tenant_id}/g" appsettings.json

sed -i -e 's#"FilePath": "/var/www/website/Merchandising/Merchandising_Media"#"FilePath": "'${media_path}_${tenant_id}'"#g' appsettings.json

sed -i -e "s#\"Url\": \"http://localhost:[0-9]\+\"#\"Url\": \"http://localhost:${random_port_merch}\"#g" appsettings.json

sed -i "s|\"https://merchapi.spectrepro.ru\"|\"https://${tenant_id}-merchapi.spectrepro.ru\"|g" appsettings.json

sed -i "s|\"https://merchtrackerapi.spectrepro.ru\"|\"https://${tenant_id}-merchtrackerapi.spectrepro.ru\"|g" appsettings.json




# End of script
