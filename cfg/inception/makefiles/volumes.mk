# Paths for volume directories
VOLUMES		:= /home/$(USER)/data
DB_VOL		:= $(VOLUMES)/mariadb
WP_VOL		:= $(VOLUMES)/wordpress

# Target to create volume directories if they don't exist
gen_volume_dir:
	@mkdir -p $(DB_VOL) $(WP_VOL)
	@echo "Volume directories created at $(DB_VOL) and $(WP_VOL)"

cleanvol: ## Remove persistent data (volumes)
	@sudo rm -rf $(VOLUMES)

.PHONY: gen_volume_dir cleanvol
