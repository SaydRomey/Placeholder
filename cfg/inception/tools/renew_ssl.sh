#!/bin/bash
DOMAIN_NAME="${USER}.42.fr"
CERT_FILE="../secrets/ssl_cert"
KEY_FILE="../secrets/ssl_key"

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout "$KEY_FILE" -out "$CERT_FILE" \
    -subj "/C=CA/ST=State/L=City/O=Organization/CN=$DOMAIN_NAME"

echo "New SSL certificate generated at $CERT_FILE"
