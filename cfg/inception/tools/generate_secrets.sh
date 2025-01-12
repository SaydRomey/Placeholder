#!/bin/bash

# Directory and file paths, relative to the project root
SECRETS_DIR="./secrets"
DB_USER_FILE="$SECRETS_DIR/db_user.txt"
DB_PASSWORD_FILE="$SECRETS_DIR/db_password.txt"
DB_ROOT_PASSWORD_FILE="$SECRETS_DIR/db_root_password.txt"
CERT_FILE="$SECRETS_DIR/ssl_cert"
KEY_FILE="$SECRETS_DIR/ssl_key"

# Default domain name for the SSL certificate
DOMAIN_NAME="${USER:-cdumais}.42.fr"

# Content for database user and SSL subject
DB_USER_CONTENT="wordpress_user"
SSL_SUBJECT="/C=CA/ST=State/L=City/O=Organization/CN=$DOMAIN_NAME"

# Create secrets directory if it doesn't exist
mkdir -p "$SECRETS_DIR"

# Write database user and generate random passwords
echo "$DB_USER_CONTENT" > "$DB_USER_FILE"
openssl rand -base64 16 > "$DB_PASSWORD_FILE"
openssl rand -base64 16 > "$DB_ROOT_PASSWORD_FILE"
echo "Database user and passwords generated in $SECRETS_DIR."

# Generate SSL certificate if it doesn't already exist
if [ ! -f "$CERT_FILE" ] || [ ! -f "$KEY_FILE" ]; then
  echo "Generating SSL certificate and key for $DOMAIN_NAME..."
  openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout "$KEY_FILE" -out "$CERT_FILE" \
    -subj "$SSL_SUBJECT"
  echo "SSL certificate and key generated in $SECRETS_DIR."
else
  echo "SSL certificate and key already exist."
fi

# Secure the secrets with restrictive permissions
chmod 600 "$SECRETS_DIR"/*

echo "Secrets generated in $SECRETS_DIR."

# # ** Or if we want options:

# # Function to generate secrets
# gen_secrets() {
#     # Create the secrets directory if it doesn't exist
#     mkdir -p "$SECRETS_DIR"

#     # Write database user and generate random passwords
#     echo "$DB_USER_CONTENT" > "$DB_USER_FILE"
#     openssl rand -base64 16 > "$DB_PASSWORD_FILE"
#     openssl rand -base64 16 > "$DB_ROOT_PASSWORD_FILE"
#     echo "Database user and passwords generated in $SECRETS_DIR."

#     # Generate SSL certificate if it doesn't already exist
#     if [ ! -f "$CERT_FILE" ] || [ ! -f "$KEY_FILE" ]; then
#         echo "Generating SSL certificate for $DOMAIN_NAME..."
#         openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
#             -keyout "$KEY_FILE" -out "$CERT_FILE" \
#             -subj "$SSL_SUBJECT"
#         echo "SSL certificate and key generated in $SECRETS_DIR."
#     else
#         echo "SSL certificate and key already exist."
#     fi
# }

# # Function to clean up secrets
# clean_secrets() {
#     rm -rf "$SECRETS_DIR"
#     echo "Removed $SECRETS_DIR."
# }

# # Main script logic to handle commands
# case "$1" in
#     gen_secrets)
#         gen_secrets
#         ;;
#     clean_secrets)
#         clean_secrets
#         ;;
#     *)
#         echo "Usage: $0 {gen_secrets|clean_secrets}"
#         exit 1
#         ;;
# esac
