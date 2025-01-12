
# **************************************************************************** #
# ----------------------------------- GIT ------------------------------------ #
# **************************************************************************** #
MAIN_BRANCH	:= $(shell git branch -r | grep -E 'origin/(main|master)' \
					| grep -v 'HEAD' | head -n 1 | sed 's@^.*origin/@@')

update:
	@echo "Updating repository from branch $(CYAN)$(MAIN_BRANCH)$(RESET)..."
	@echo "Are you sure you want to update the repo? [y/N] " \
	&& read ANSWER; \
	if [ "$$ANSWER" = "y" ] || [ "$$ANSWER" = "Y" ]; then \
		git pull origin $(MAIN_BRANCH); \
		echo "Repository updated."; \
	else \
		echo "canceling update..."; \
	fi

.PHONY: update
# **************************************************************************** #
# --------------------------------- GITHUB ----------------------------------- #
# **************************************************************************** #
REPO_LINK	:= https://github.com/SaydRomey/

repo:
	@echo "Opening $(AUTHOR)'s github repo..."
	@$(OPEN) $(REPO_LINK);

repo: ## Open author's CPP repo on github
	@echo "Opening $(AUTHOR)'s github repo..."
	@$(OPEN) $(REPO_LINK) $(STDOUT_NULL) $(STDERR_STDOUT) $(IN_BACKGROUND)

gitignore: ## Create the .gitignore file with multi-line variable in 'TEMPLATES' section
	@echo "Creating gitignore file..."
	@echo "$$GITIGNORE_CONTENT" > .gitignore

.PHONY: repo


# **************************************************************************** #
# -------------------------------- SUBMODULES  ------------------------------- #
# **************************************************************************** #
INIT_CHECK	:= $(LIB_DIR)/.init_check
INIT		:= $(if $(wildcard $(INIT_CHECK)),,init_submodules)

# all: $(INIT) $(NAME)

# **************************************************************************** #
# ------------------------------- TEMPLATES ---------------------------------- #
# **************************************************************************** #
define GITIGNORE_CONTENT
# object files and archives in all directories
*.o
*.a

# PDFs
*.pdf

# macOS specific files
*.dSYM
.DS_Store

# Visual Studio Code settings
.vscode

# tmp, and obj directories in all directories
**/tmp/
**/obj/

# output files
out.txt

# # Executables

# Default executable
a.out

# $(MODULE) specific executables
$(NAME)

endef

export GITIGNORE_CONTENT
# **************************************************************************** #