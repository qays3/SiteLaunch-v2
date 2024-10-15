#!/bin/bash

echo "Cleaning up SiteLaunch..."
docker-compose down
docker rmi -f $(docker images -q)
echo "Cleanup completed."
