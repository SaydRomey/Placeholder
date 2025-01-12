# Paths for the secrets directory and files, relative to the project root
SECRETS_DIR = ./secrets
DB_USER_FILE = $(SECRETS_DIR)/db_user.txt
DB_PASSWORD_FILE = $(SECRETS_DIR)/db_password.txt
DB_ROOT_PASSWORD_FILE = $(SECRETS_DIR)/db_root_password.txt
CERT_FILE = $(SECRETS_DIR)/ssl_cert
KEY_FILE = $(SECRETS_DIR)/ssl_key

# Default domain name for the SSL certificate
DOMAIN_NAME := $(or $(USER), cdumais).42.fr

# Define multi-line variables for each secret file
define DB_USER_CONTENT
wordpress_user
endef
export DB_USER_CONTENT

define SSL_SUBJECT
/C=CA/ST=State/L=City/O=Organization/CN=$(DOMAIN_NAME)
endef
export SSL_SUBJECT

# Target to create the secrets directory and generate files
gen_secrets:
	@mkdir -p $(SECRETS_DIR)

	@echo "$$DB_USER_CONTENT" > $(DB_USER_FILE)
	@openssl rand -base64 16 > $(DB_PASSWORD_FILE)
	@openssl rand -base64 16 > $(DB_ROOT_PASSWORD_FILE)
	@echo "Database user and passwords generated in $(SECRETS_DIR)."

	@if [ ! -f $(CERT_FILE) ] || [ ! -f $(KEY_FILE) ]; then \
		echo "Generating SSL certificate for $(DOMAIN_NAME)..."; \
		openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
		-keyout $(KEY_FILE) -out $(CERT_FILE) \
		-subj "$$SSL_SUBJECT"; \
		echo "SSL certificate and key generated in $(SECRETS_DIR)."; \
	else \
		echo "SSL certificate and key already exist."; \
	fi

clean_secrets:
	@rm -rf $(SECRETS_DIR)
	@echo "Removed $(SECRETS_DIR)."

.PHONY: gen_secrets clean_secrets
