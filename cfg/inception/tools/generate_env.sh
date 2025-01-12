#!/bin/bash

# Path to the .env file
ENV_FILE="../srcs/.env"

# Pulling environment info from the host
USER_NAME=${USER:-cdumais}
COUNTRY=${COUNTRY:-CA}
DOMAIN_NAME="${USER_NAME}.42.fr"

# Write variables to .env file
ENV_CONTENT=$(cat <<EOL
# Environment variables
USER=$USER_NAME
DOMAIN_NAME=$DOMAIN_NAME
COUNTRY=$COUNTRY

# Database configuration
DB_NAME=wordpress_db
DB_HOST=mariadb
DB_USER_FILE=/run/secrets/db_user
DB_PASSWORD_FILE=/run/secrets/db_password
DB_ROOT_PASSWORD_FILE=/run/secrets/db_root_password
EOL
)

echo "$ENV_CONTENT" > "$ENV_FILE"
echo ".env file created at $ENV_FILE with host information."

# # Function to generate the .env file
# gen_env() {
#     echo "$ENV_CONTENT" > "$ENV_FILE"
#     echo ".env file created at $ENV_FILE with host information."
# }

# # Function to clean the .env file
# clean_env() {
#     rm -rf "$ENV_FILE"
#     echo "$ENV_FILE deleted."
# }

# # Function to reset the .env file
# reset_env() {
#     clean_env
#     gen_env
# }

# # Main script logic to handle commands
# case "$1" in
#     gen_env)
#         gen_env
#         ;;
#     clean_env)
#         clean_env
#         ;;
#     reset_env)
#         reset_env
#         ;;
#     *)
#         echo "Usage: $0 {gen_env|clean_env|reset_env}"
#         exit 1
#         ;;
# esac
