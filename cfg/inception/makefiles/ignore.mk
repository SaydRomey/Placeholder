# Paths for the .gitignore and .dockerignore files
GITIGNORE_FILE = .gitignore
SERVICE_DIR = ./srcs/requirements
NGINX_DOCKERIGNORE = $(SERVICE_DIR)/nginx/.dockerignore
WORDPRESS_DOCKERIGNORE = $(SERVICE_DIR)/wordpress/.dockerignore
MARIADB_DOCKERIGNORE = $(SERVICE_DIR)/mariadb/.dockerignore

# Multi-line variable for .dockerignore content
define DOCKERIGNORE_CONTENT
# Ignore Git and version control files
.git
.gitignore

# Ignore temporary and swap files
*.log
*.swp
*~

# Ignore secrets and environment files
secrets/
srcs/.env
endef
export DOCKERIGNORE_CONTENT

# Multi-line variable for .gitignore content
define GITIGNORE_CONTENT
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
*~

endef
export GITIGNORE_CONTENT

# Target to generate .gitignore
gen_gitignore:
	@echo "$$GITIGNORE_CONTENT" > $(GITIGNORE_FILE)
	@echo ".gitignore created at $(GITIGNORE_FILE)."

# Target to generate .dockerignore files for all services
gen_dockerignore:
	@echo "$$DOCKERIGNORE_CONTENT" > $(NGINX_DOCKERIGNORE)
	@echo ".dockerignore created at $(NGINX_DOCKERIGNORE)."
	@echo "$$DOCKERIGNORE_CONTENT" > $(WORDPRESS_DOCKERIGNORE)
	@echo ".dockerignore created at $(WORDPRESS_DOCKERIGNORE)."
	@echo "$$DOCKERIGNORE_CONTENT" > $(MARIADB_DOCKERIGNORE)
	@echo ".dockerignore created at $(MARIADB_DOCKERIGNORE)."
