#!/bin/bash

while getopts u:c:l: option; do
    case "${option}" in
        u) USERNAME=${OPTARG};;
        c) CLIENT_ID=${OPTARG};;
        l) INSTANCE_URL=${OPTARG};;
    esac
done

echo "Setting up connection..."
mkdir /keys
echo $SFDC_SERVER_KEY | base64 -d > /keys/server.key

JWT_LOGIN="sfdx force:auth:jwt:grant --clientid $CLIENT_ID --jwtkeyfile /keys/server.key --username $USERNAME"
if [ $INSTANCE_URL != https://login.salesforce.com ]; then
    JWT_LOGIN="$JWT_LOGIN  --instanceurl $INSTANCE_URL"
else
    JWT_LOGIN="$JWT_LOGIN  --setdefaultdevhubusername"
fi

echo "Authenticating..."
echo $JWT_LOGIN
eval $JWT_LOGIN