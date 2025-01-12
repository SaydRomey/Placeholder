#!/bin/bash

echo "Cleaning up logs for NGINX and WordPress..."

# NGINX logs
docker exec nginx_container_name sh -c 'rm -f /var/log/nginx/*.log'
# WordPress/PHP logs (if any)
docker exec wordpress_container_name sh -c 'rm -f /var/log/php*.log'

echo "Logs cleaned up."
