#!/bin/bash
sudo apt-get update -y
sudo apt-get install -y iptables curl
sudo apt install -y golang docker-compose
sudo apt-get install jq

chmod +x scripts/*


echo "Setup complete."