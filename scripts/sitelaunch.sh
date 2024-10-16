#!/bin/bash
LOCAL_IP=$1
LOCAL_PORT=$2
ACTION=$3
PUBLIC_IP=$(curl -s ifconfig.me)
PUBLIC_PORT=$LOCAL_PORT
LOG_FILE="../logs/sitelaunch.log"

 
RED='\033[1;31m'
GREEN='\033[1;32m'
BOLD='\033[1m'
NC='\033[0m'  

 
if [ ! -d "../logs" ]; then
    mkdir -p ../logs
fi
if [ ! -f "$LOG_FILE" ]; then
    touch "$LOG_FILE"
fi

start_service() {
    echo -e "${BOLD}${GREEN}Forwarding $PUBLIC_IP:$PUBLIC_PORT to $LOCAL_IP:$LOCAL_PORT${NC}" | tee -a "$LOG_FILE"
    sudo iptables -t nat -A PREROUTING -p tcp --dport "$PUBLIC_PORT" -j DNAT --to-destination "$LOCAL_IP:$LOCAL_PORT"
    sudo iptables -t nat -A POSTROUTING -p tcp -d "$LOCAL_IP" --dport "$LOCAL_PORT" -j MASQUERADE
    echo -e "${BOLD}${GREEN}Service running on public IP: $PUBLIC_IP:$PUBLIC_PORT${NC}" | tee -a "$LOG_FILE"
    echo $PUBLIC_IP > ../scripts/service.public_ip
    echo $PUBLIC_PORT > ../scripts/service.public_port
}

stop_service() {
    if [ -f ../scripts/service.public_ip ] && [ -f ../scripts/service.public_port ]; then
        PUBLIC_IP=$(cat ../scripts/service.public_ip)
        PUBLIC_PORT=$(cat ../scripts/service.public_port)
        echo -e "${BOLD}${GREEN}Stopping forwarding for $PUBLIC_IP:$PUBLIC_PORT${NC}" | tee -a "$LOG_FILE"
        sudo iptables -t nat -D PREROUTING -p tcp --dport "$PUBLIC_PORT" -j DNAT --to-destination "$LOCAL_IP:$LOCAL_PORT"
        sudo iptables -t nat -D POSTROUTING -p tcp -d "$LOCAL_IP" --dport "$LOCAL_PORT" -j MASQUERADE
        rm ../scripts/service.public_ip
        rm ../scripts/service.public_port
        echo -e "${BOLD}${GREEN}Service stopped.${NC}" | tee -a "$LOG_FILE"
    else
        echo -e "${BOLD}${RED}No public service is running.${NC}" | tee -a "$LOG_FILE"
    fi
}

case "$ACTION" in
    start)
        start_service
        ;;
    stop)
        stop_service
        ;;
    *)
        echo -e "${BOLD}${RED}Invalid action. Use start or stop.${NC}"
        exit 1
        ;;
esac
