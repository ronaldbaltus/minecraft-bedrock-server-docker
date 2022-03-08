#!/bin/bash

if [ -f /bedrock-server/config/server.properties ]
then
    echo "Copying server.properties"
    cp -f /bedrock-server/config/server.properties /bedrock-server/server.properties
else
    echo "Replacing template with environment variables"
    envsubst < /bedrock-server/server.properties.template > /bedrock-server/server.properties
fi

cp -f /bedrock-server/config/whitelist.json /bedrock-server/whitelist.json
cp -f /bedrock-server/config/permissions.json /bedrock-server/permissions.json

./bedrock_server