#!/bin/bash

CONFIG_FILE="/data/tinyproxy.conf"

if [[ ! -f "$CONFIG_FILE" ]]; then
  username="proxy"
  randomPassword=$(tr -dc 'A-Za-z0-9_' < /dev/urandom | head -c 32)
  echo "Port 8888
Listen 0.0.0.0
Timeout 600
BasicAuth $username $randomPassword" > "$CONFIG_FILE"
  echo "Created config file: ${CONFIG_FILE}"
  echo "Credentails (HTTP basic auth): $username $randomPassword"
fi

tinyproxy -d -c "$CONFIG_FILE"
