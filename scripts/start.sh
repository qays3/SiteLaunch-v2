#!/bin/bash

if [ "$#" -ne 4 ]; then
    echo "Usage: $0 -w <local_address> -p <public_port>"
    exit 1
fi

while getopts ":w:p:" opt; do
    case $opt in
        w) LOCAL_ADDR=$OPTARG ;;
        p) PUBLIC_PORT=$OPTARG ;;
        \?) echo "Invalid option -$OPTARG" >&2 ;;
    esac
done

if [ -z "$LOCAL_ADDR" ] || [ -z "$PUBLIC_PORT" ]; then
    echo "Both local address and public port must be provided."
    exit 1
fi

echo "Starting SiteLaunch for $LOCAL_ADDR on public port $PUBLIC_PORT..."
 