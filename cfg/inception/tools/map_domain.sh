#!/bin/bash

# Default domain name
DOMAIN_NAME="${USER:-cdumais}.42.fr"

# Function to add domain mapping to /etc/hosts
map_domain() {
    if ! grep -q "$DOMAIN_NAME" /etc/hosts; then
        sudo tee -a /etc/hosts > /dev/null <<EOL
127.0.0.1 $DOMAIN_NAME static.$DOMAIN_NAME
EOL
        echo "Domain mapping for $DOMAIN_NAME added to /etc/hosts."
    else
        echo "Domain mapping for $DOMAIN_NAME already exists in /etc/hosts."
    fi
}

# Run the function
map_domain
