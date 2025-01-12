# Path to the .env file relative to the project root
ENV_FILE = srcs/.env

# Default values if environment variables are missing
USER_NAME := $(or $(USER), cdumais)
COUNTRY := $(or $(COUNTRY), CA)
DOMAIN_NAME := $(USER_NAME).42.fr

# Define multi-line variable for the .env content
define ENV_CONTENT
# Environment variables
USER=$(USER_NAME)
DOMAIN_NAME=$(DOMAIN_NAME)
COUNTRY=$(COUNTRY)

# Database configuration
DB_NAME=wordpress
DB_HOST=mariadb
DB_USER_FILE=/run/secrets/db_user
DB_PASSWORD_FILE=/run/secrets/db_password
DB_ROOT_PASSWORD_FILE=/run/secrets/db_root_password
endef
export ENV_CONTENT

# Target to generate the .env file
gen_env:
	@echo "$$ENV_CONTENT" > $(ENV_FILE)
	@echo ".env file created at $(ENV_FILE) with host information."

clean_env:
	@rm -rf $(ENV_FILE)
	@echo "$(ENV_FILE) deleted." 

reset_env: clean_env gen_env

.PHONY: gen_env clean_env reset_env

# Target to add domain mapping to /etc/hosts
map_domain:
	@if ! grep -q "$(DOMAIN_NAME)" /etc/hosts; then \
		echo "127.0.0.1 $(DOMAIN_NAME) static.$(DOMAIN_NAME)" | sudo tee -a /etc/hosts > /dev/null; \
		echo "Domain mapping for $(DOMAIN_NAME) added to /etc/hosts."; \
	else \
		echo "Domain mapping for $(DOMAIN_NAME) already exists in /etc/hosts."; \
	fi

.PHONY: map_domain
