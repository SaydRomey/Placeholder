#!/bin/bash

# Path definitions
GITIGNORE_FILE=".gitignore"
SERVICE_DIR="./srcs/requirements"
NGINX_DOCKERIGNORE="$SERVICE_DIR/nginx/.dockerignore"
WORDPRESS_DOCKERIGNORE="$SERVICE_DIR/wordpress/.dockerignore"
MARIADB_DOCKERIGNORE="$SERVICE_DIR/mariadb/.dockerignore"

# .dockerignore content
DOCKERIGNORE_CONTENT=$(cat << EOF
# Ignore Git and version control files
.git
.gitignore

# Ignore unnecessary files
*.log
*.swp
*~

# Ignore secrets and environment files
secrets/
srcs/.env
EOF
)

# Generate .dockerignore for services
echo "$DOCKERIGNORE_CONTENT" > "$NGINX_DOCKERIGNORE"
echo ".dockerignore file created at $NGINX_DOCKERIGNORE"
echo "$DOCKERIGNORE_CONTENT" > "$WORDPRESS_DOCKERIGNORE"
echo ".dockerignore file created at $WORDPRESS_DOCKERIGNORE"
echo "$DOCKERIGNORE_CONTENT" > "$MARIADB_DOCKERIGNORE"
echo ".dockerignore file created at $MARIADB_DOCKERIGNORE"


# .gitignore content
GITIGNORE_CONTENT=$(cat << EOF
# Temporary folder ('make pdf' creates it to place the PDF with the instructions)
tmp
.DS_Store

# Environment files and secrets
srcs/.env
secrets/

# Docker-related generated files
*.log
*.pid
*.sock
*.tmp

# Editor swap files
*.swp
*
EOF
)

# Generate .gitignore
echo "$GITIGNORE_CONTENT" > "$GITIGNORE_FILE"
echo ".gitignore created at $GITIGNORE_FILE."



# # Function to generate .dockerignore files for all services
# gen_dockerignore() {
#     echo "$DOCKERIGNORE_CONTENT" > "$NGINX_DOCKERIGNORE"
#     echo ".dockerignore created at $NGINX_DOCKERIGNORE."
    
#     echo "$DOCKERIGNORE_CONTENT" > "$WORDPRESS_DOCKERIGNORE"
#     echo ".dockerignore created at $WORDPRESS_DOCKERIGNORE."
    
#     echo "$DOCKERIGNORE_CONTENT" > "$MARIADB_DOCKERIGNORE"
#     echo ".dockerignore created at $MARIADB_DOCKERIGNORE."
# }

# # Function to generate .gitignore
# gen_gitignore() {
# 	echo "$GITIGNORE_CONTENT" > "$GITIGNORE_FILE"
# 	echo ".gitignore created at $GITIGNORE_FILE."
# }

# # Function to generate .dockerignore for all services
# gen_dockerignore() {
# 	echo "$GITIGNORE_CONTENT" > "$GITIGNORE_FILE"
# 	echo ".gitignore created at $GITIGNORE_FILE."
# }

# # Main script logic to handle commands
# case "$1" in
#     gen_gitignore)
#         gen_gitignore
#         ;;
#     gen_dockerignore)
#         gen_dockerignore
#         ;;
#     *)
#         echo "Usage: $0 {gen_gitignore|gen_dockerignore}"
#         exit 1
#         ;;
# esac
