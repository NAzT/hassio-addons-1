#!/usr/bin/env bashio
set -e

# https://github.com/hassio-addons/bashio

bashio::log.info "Public key:"

cat /root/.ssh/id_rsa.pub

# BASE="ssh -o StrictHostKeyChecking=no"
# TUN="-o ExitOnForwardFailure=yes -o ServerAliveInterval=30 -N"

configPath="/etc/cloudflared/config.yml"
mkdir -p /etc/cloudflared

echo "log: stdout" > $configPath
bashio::log.info "Hello this is inf o log from bashio!"
# if bashio::var.has_value "$(bashio::addon.port 4040)"; then
#   echo "web_addr: 0.0.0.0:$(bashio::addon.port 4040)" >> $configPath
# fi
if bashio::var.has_value "$(bashio::config 'host')"; then
  echo "host: $(bashio::config 'host')" >> $configPath
fi

if bashio::var.has_value "$(bashio::config 'url')"; then
  echo "url: $(bashio::config 'url')" >> $configPath
fi

# if bashio::var.has_value "$(bashio::config 'auth_token')"; then
#   echo "authtoken: $(bashio::config 'auth_token')" >> $configPath
# fi
# if bashio::var.has_value "$(bashio::config 'region')"; then
#   echo "region: $(bashio::config 'region')" >> $configPath
# else
#   echo "No region defined, default region is US."
# fi
# cat $configPath
configfile=$(cat $configPath)
bashio::log.info "Config file: \n${configfile}"
# cloudflared --url localhost:8123