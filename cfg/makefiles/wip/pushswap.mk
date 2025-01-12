
# **************************************************************************** #
# -------------------------------- VISUAL ------------------------------------ #
# **************************************************************************** #
VISUAL_URL		:= https://github.com/o-reo/push_swap_visualizer
VISUAL_DIR		:= push_swap_visualizer
VISUAL_BIN		:= $(VISUAL_DIR)/build/bin/visualizer
VISUAL_EXEC		:= visualizer
VISUAL_CONFIG	:= imgui.ini

visual: all ## build and execute the push_swap visualizer
	@if [ ! -f "$(VISUAL_EXEC)" ]; then \
		echo "Visualizer not found. Building..."; \
		$(MAKE) visual_setup; \
	fi
	@echo "Launching $(BOLD)$(PURPLE)$(VISUAL_EXEC)$(RESET)..."
	@./$(VISUAL_EXEC) || { \
		echo "Error: $(VISUAL_BIN) failed to run. Rebuilding..."; \
		$(REMOVE) $(VISUAL_EXEC); \
		$(MAKE) visual_setup; \
		./$(VISUAL_EXEC); \
	}

visual_setup: ## Clone and build the visualizer -> 'visual' helper target
	@if [ ! -d "$(VISUAL_DIR)" ]; then \
		echo "Cloning vizualiser repository..."; \
		git clone $(VISUAL_URL); \
	fi
	@echo "Building $(VISUAL_BIN)..."; \
	cd $(VISUAL_DIR) && mkdir -p build && cd build && cmake -Wno-dev .. && make
	@cp $(VISUAL_BIN) $(VISUAL_EXEC) || echo "Error: Failed to copy $(VISUAL_BIN) to project root."
	@echo "Build complete. Executable available as $(VISUAL_EXEC)."

vclean: ## Clean up the visualizer and configuration
	@if [ -d "$(VISUAL_DIR)" ] || [ -f "$(VISUAL_BIN)" ] || [ -f "$(VISUAL_CONFIG)" ] || [ -f "$(VISUAL_EXEC)" ]; then \
		echo "Cleaning visualizer files..."; \
		[ -d "$(VISUAL_DIR)" ] && echo "Removing directory: $(VISUAL_DIR)" && $(REMOVE) $(VISUAL_DIR); \
		[ -f "$(VISUAL_BIN)" ] && echo "Removing executable: $(VISUAL_BIN)" && $(REMOVE) $(VISUAL_BIN); \
		[ -f "$(VISUAL_EXEC)" ] && echo "Removing root executable: $(VISUAL_EXEC)" && $(REMOVE) $(VISUAL_EXEC); \
		[ -f "$(VISUAL_CONFIG)" ] && echo "Removing config file: $(VISUAL_CONFIG)" && $(REMOVE) $(VISUAL_CONFIG); \
		echo "[$(BOLD)$(PURPLE)$(NAME)$(RESET)] \
		$(GREEN)Visualizer files removed$(RESET)"; \
	else \
		echo "[$(BOLD)$(PURPLE)$(NAME)$(RESET)] \
		$(YELLOW)No visualizer files to remove$(RESET)"; \
	fi

.PHONY: visual visual_setup vclean

# **************************************************************************** #
# ------------------------------- CHECKER ------------------------------------ #
# **************************************************************************** #
CHECKER			:= checker_OS
MAC_CHECKER		:= utils/checker_Mac
LINUX_CHECKER	:= utils/checker_linux
ARGS			:= 4 67 3 87 23

# (the links might break later..)
# MAC_CHECKER		:= https://cdn.intra.42.fr/document/document/25668/checker_Mac
# LINUX_CHECKER	:= https://cdn.intra.42.fr/document/document/25669/checker_linux

# get_checker: ## Gets the 42's push_swap checker
# 	@if [ -f "$(CHECKER)" ]; then \
# 		echo "$(BOLD)$(GREEN)Checker is already available: $(CHECKER)$(RESET)"; \
# 	else \
# 		if [ "$(OS)" = "Darwin" ]; then \
# 			echo "Downloading $(BOLD)$(ORANGE)checker_Mac$(RESET)..."; \
# 			curl -o $(CHECKER) $(MAC_CHECKER); \
# 		elif [ "$(OS)" = "Linux" ]; then \
# 			echo "Downloading $(BOLD)$(ORANGE)checker_linux$(RESET)..."; \
# 			curl -o $(CHECKER) $(LINUX_CHECKER); \
# 		else \
# 			echo "Error: Checker not available for OS: $(OS)"; \
# 			exit 1; \
# 		fi; \
# 		chmod +x $(CHECKER); \
# 		echo "$(BOLD)$(GREEN)Checker downloaded and ready to use: $(CHECKER)$(RESET)"; \
# 	fi

get_checker: ## Gets checker from utils directory
	@if [ ! -f "$(CHECKER)" ]; then \
		if [ "$(OS)" = "Darwin" ]; then \
			cp $(MAC_CHECKER) ./$(CHECKER) || echo "Error: Failed to copy $(MAC_CHECKER) to project root..."; \
		elif [ "$(OS)" = "Linux" ]; then \
			cp $(LINUX_CHECK) ./$(CHECKERER) || echo "Error: Failed to copy $(LINUX_CHECKER) to project root..."; \
		else \
			echo "Error: Checker not available for OS: $(OS)"; \
			exit 1; \
		fi; \
		chmod +x $(CHECKER); \
		echo "$(GRAYTALIC)$(CHECKER) ready...$(RESET)"; \
	fi

checker: $(NAME) get_checker ## Run push_swap with checker_OS
	@if [ -z "$(ARGS)" ]; then \
		echo "$(BOLD)$(RED)No arguments provided. Use ARGS=\"<numbers>\" make checker$(RESET)"; \
		exit 1; \
	fi
	@echo "$(GRAYTALIC)./$(NAME) \"$(ARGS)\" | ./$(CHECKER) \"$(ARGS)\"$(RESET)"
	@./$(NAME) $(ARGS) | ./$(CHECKER) $(ARGS)

checker_clean: ## Removes the checker_OS
	@if [ -f "$(CHECKER)" ]; then \
		$(REMOVE) $(CHECKER); \
		echo "[$(BOLD)$(PURPLE)$(NAME)$(RESET)] \
		$(GREEN)$(CHECKER) removed$(RESET)"; \
	else \
		echo "[$(BOLD)$(PURPLE)$(NAME)$(RESET)] \
		$(YELLOW)No checker to remove$(RESET)"; \
	fi

.PHONY: get_checker checker checker_clean
