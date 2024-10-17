#!/bin/bash

LOCAL_IP=$1
LOCAL_PORT=$2
ACTION=$3

 
PUBLIC_IP=$(curl -s4 ifconfig.me)
PUBLIC_PORT=$LOCAL_PORT
LOG_FILE="./logs/sitelaunch.log"
JSON_FILE="./json/IP_Port.json"

 
RED='\033[1;31m'
GREEN='\033[1;32m'
BOLD='\033[1m'
NC='\033[0m'

 
mkdir -p ./logs
touch "$LOG_FILE"
mkdir -p ./json

 
is_port_in_use() {
    if [ -f "$JSON_FILE" ]; then
        ACTIVE=$(jq -r ".active" "$JSON_FILE")
        if [[ "$ACTIVE" == "true" ]]; then
            return 0   
        fi
    fi
    return 1   
}

 
start_service() {
    if is_port_in_use; then
        echo -e "${BOLD}${RED}Port $LOCAL_PORT is already in use. Stopping existing service...${NC}" | tee -a "$LOG_FILE"
        stop_service   
    fi

    echo -e "${BOLD}${GREEN}Forwarding $LOCAL_IP:$LOCAL_PORT to $PUBLIC_IP:$PUBLIC_PORT${NC}" | tee -a "$LOG_FILE"

     
    if ! sudo iptables -t nat -A PREROUTING -p tcp --dport "$PUBLIC_PORT" -j DNAT --to-destination "$LOCAL_IP:$LOCAL_PORT"; then
        echo -e "${BOLD}${RED}Failed to add PREROUTING rule.${NC}" | tee -a "$LOG_FILE"
        exit 1
    fi

    if ! sudo iptables -t nat -A POSTROUTING -p tcp -d "$LOCAL_IP" --dport "$LOCAL_PORT" -j MASQUERADE; then
        echo -e "${BOLD}${RED}Failed to add POSTROUTING rule.${NC}" | tee -a "$LOG_FILE"
        exit 1
    fi

    echo -e "${BOLD}${GREEN}Service running on public IP: $PUBLIC_IP:$PUBLIC_PORT${NC}" | tee -a "$LOG_FILE"
    echo "{ \"localip\":\"$LOCAL_IP:$LOCAL_PORT\", \"publicip\":\"$PUBLIC_IP:$PUBLIC_PORT\", \"active\": true }" > "$JSON_FILE"
}

 
stop_service() {
    if [ -f "$JSON_FILE" ]; then
        PUBLIC_PORT=$(jq -r '.publicip' "$JSON_FILE" | cut -d':' -f2)
        echo -e "${BOLD}${GREEN}Stopping forwarding for $PUBLIC_IP:$PUBLIC_PORT${NC}" | tee -a "$LOG_FILE"
        

        if ! sudo iptables -t nat -D PREROUTING -p tcp --dport "$PUBLIC_PORT" -j DNAT --to-destination "$LOCAL_IP:$LOCAL_PORT"; then
            echo -e "${BOLD}${RED}Failed to remove PREROUTING rule.${NC}" | tee -a "$LOG_FILE"
        fi

        if ! sudo iptables -t nat -D POSTROUTING -p tcp -d "$LOCAL_IP" --dport "$LOCAL_PORT" -j MASQUERADE; then
            echo -e "${BOLD}${RED}Failed to remove POSTROUTING rule.${NC}" | tee -a "$LOG_FILE"
        fi

        echo "{ \"localip\":\"$LOCAL_IP:$LOCAL_PORT\", \"publicip\":\"$PUBLIC_IP:$PUBLIC_PORT\", \"active\": false }" > "$JSON_FILE"
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
        echo -e "${BOLD}${RED}Invalid action. Use start or stop.${NC}" | tee -a "$LOG_FILE"
        exit 1
        ;;
esac
