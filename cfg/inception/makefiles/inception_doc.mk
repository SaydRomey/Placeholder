
# **************************************************************************** #
# ------------------------------ DOCUMENTATION ------------------------------- #
# **************************************************************************** #
# TODO later: eventually add docs for bonuses

URL_DOCKER	:= https://docs.docker.com/engine/
URL_COMPOSE	:= https://docs.docker.com/compose/
URL_IMAGES	:= https://docs.docker.com/build/building/base-images/
URL_ALPINE	:= https://hub.docker.com/_/alpine
URL_DEBIAN	:= https://hub.docker.com/_/debian
URL_NGINX	:= https://hub.docker.com/_/nginx
URL_WP		:= https://hub.docker.com/_/wordpress
URL_PHP		:= https://hub.docker.com/_/php
URL_MARIA	:= https://hub.docker.com/_/mariadb
URL_VOLUMES	:= https://docs.docker.com/engine/storage/volumes/
URL_NETWORK	:= https://docs.docker.com/engine/network/
URL_RESTART	:= https://docs.docker.com/reference/cli/docker/container/restart/
URL_BEST	:= https://docs.docker.com/build/building/best-practices/
URL_SECRETS	:= https://docs.docker.com/engine/swarm/secrets/
URL_IGNORE	:= https://docs.docker.com/build/concepts/context/#dockerignore-files
URL_TLS		:= https://nginx.org/en/docs/http/configuring_https_servers.html

doc: ## Offer a list of documentation URL links
	@clear
	@echo "Select documentation subject:"
	@echo "  0. Docker documentation"
	@echo "  1. Docker Compose documentation"
	@echo "  2. Building Docker images"
	@echo "  3. Alpine image on Docker Hub"
	@echo "  4. Debian image on Docker Hub"
	@echo "  5. NGINX on Docker Hub"
	@echo "  6. WordPress on Docker Hub"
	@echo "  7. PHP on Docker Hub"
	@echo "  8. MariaDB on Docker Hub"
	@echo "  9. Docker volumes documentation"
	@echo " 10. Docker networking documentation"
	@echo " 11. Container restart policies"
	@echo " 12. Best practices for building Docker files"
	@echo " 13. Docker secrets documentation"
	@echo " 14. Dockerignore files documentation"
	@echo " 15. TLS configuration in NGINX"
	@read url_choice; \
	case $$url_choice in \
		0) CHOICE=$(URL_DOCKER);; \
		1) CHOICE=$(URL_COMPOSE);; \
		2) CHOICE=$(URL_IMAGES);; \
		3) CHOICE=$(URL_ALPINE);; \
		4) CHOICE=$(URL_DEBIAN);; \
		5) CHOICE=$(URL_NGINX);; \
		6) CHOICE=$(URL_WP);; \
		7) CHOICE=$(URL_PHP);; \
		8) CHOICE=$(URL_MARIA);; \
		9) CHOICE=$(URL_VOLUMES);; \
		10) CHOICE=$(URL_NETWORK);; \
		11) CHOICE=$(URL_RESTART);; \
		12) CHOICE=$(URL_BEST);; \
		13) CHOICE=$(URL_SECRETS);; \
		14) CHOICE=$(URL_IGNORE);; \
		15) CHOICE=$(URL_TLS);; \
		*) echo "Invalid choice. Exiting." ; exit 1;; \
	esac; \
	$(OPEN) $$CHOICE $(STDOUT_NULL) $(STDERR_STDOUT) $(IN_BACKGROUND)
	@clear
	@echo "Opening documentation..."

.PHONY: doc
# **************************************************************************** #
# ------------------------------ TUTORIALS ----------------------------------- #
# **************************************************************************** #
TUTO_DOCKER      := https://youtu.be/eGz9DS-aIeY
TUTO_COMPOSE     := https://youtu.be/DM65_JyGxCo
TUTO_NETWORK     := https://youtu.be/bKFMS5C4CG0
TUTO_TLS         := https://www.howtoforge.com/how-to-enable-tls-13-in-nginx/
TUTO_HOSTFILE    := https://www.howtogeek.com/27350/beginner-geek-how-to-edit-your-hosts-file/

# URL_STATIC	:= https://docs.nginx.com/nginx/admin-guide/web-server/serving-static-content/

# https://github.com/jotavare/inception


tuto: ## Offer a list of tutorial links
	@clear
	@echo "Select tutorial subject:"
	@echo "  0. Docker basics video tutorial"
	@echo "  1. Docker Compose video tutorial"
	@echo "  2. Docker networking video tutorial"
	@echo "  3. Enabling TLS in NGINX"
	@echo "  4. Editing your hosts file (domain to IP)"
	@read url_choice; \
	case $$url_choice in \
		0) CHOICE=$(TUTO_DOCKER);; \
		1) CHOICE=$(TUTO_COMPOSE);; \
		2) CHOICE=$(TUTO_NETWORK);; \
		3) CHOICE=$(TUTO_TLS);; \
		4) CHOICE=$(TUTO_HOSTFILE);; \
		*) echo "Invalid choice. Exiting." ; exit 1;; \
	esac; \
	$(OPEN) $$CHOICE $(STDOUT_NULL) $(STDERR_STDOUT) $(IN_BACKGROUND)
	@clear
	@echo "Opening tutorial..."

.PHONY: tuto

# **************************************************************************** #
# ------------------------------- DECORATIONS -------------------------------- #
# **************************************************************************** #
define DOCKER_LOGO

                    ##        .            
              ## ## ##       ==            
           ## ## ## ##      ===            
       /""""""""""""""""\___/ ===        
  ~~~ {~~ ~~~~ ~~~ ~~~~ ~~ ~ /  ===- ~~~   
       \______ o          __/            
         \    \        __/             
          \____\______/                

endef
export DOCKER_LOGO

logo: ## Print Docker's logo in ASCII art
	@echo "$(BLUE) $(BOLD) $$DOCKER_LOGO $(RESET)"

.PHONY: logo
