# (WIP) -> **If we want to work with shell scripts instead of makefiles

# Paths to scripts
SCRIPTS			:= ./tools
ENV_SCRIPT		:= $(SCRIPTS)/generate_env.sh
SECRETS_SCRIPT	:= $(SCRIPTS)/generate_secrets.sh
DOMAIN_SCRIPT	:= $(SCRIPTS)/map_domain.sh

# Generated files
SENTINEL_FILE = ./.generated_sentinel
SECRETS_DIR = ./secrets
ENV_FILE = ./srcs/.env

# Custom target names to avoid conflicts with main Makefile
gen_check_setup:
	@chmod +x $(ENV_SCRIPT) $(SECRETS_SCRIPT) $(DOMAIN_SCRIPT)
	@echo "Permissions set for scripts."

gen_setup:
	@if [ ! -f $(SENTINEL_FILE) ]; then \
		echo "Generating .env and secrets..."; \
		$(ENV_SCRIPT); \
		$(SECRETS_SCRIPT); \
		touch $(SENTINEL_FILE); \
		echo "Setup complete. Sentinel file created."; \
	else \
		echo "Setup already completed. Skipping generation."; \
	fi

gen_clean:
	@echo "Cleaning generated files..."
	@rm -f $(ENV_FILE)
	@rm -rf $(SECRETS_DIR)
	@rm -f $(SENTINEL_FILE)
	@echo "Clean-up complete."

.PHONY: gen_check_setup gen_setup gen_clean
