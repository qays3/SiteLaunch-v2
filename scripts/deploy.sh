#!/bin/bash

echo "Deploying SiteLaunch..."
docker-compose down
docker-compose up --build -d
echo "SiteLaunch deployed successfully."
