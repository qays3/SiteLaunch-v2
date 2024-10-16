#!/bin/bash
sudo apt-get update -y
sudo apt-get install -y iptables curl
sudo apt install -y golang docker-compose
chmod +x scripts/*


echo "Setup complete."