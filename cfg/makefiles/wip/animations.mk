
# **************************************************************************** #
# ------------------------------- ANIMATIONS --------------------------------- #
# **************************************************************************** #
# TODO: add a chmod + x to the script
# TODO: set this up during mlx42's compilation? or when installing brew, cmake, glfw
# 
# Animation shell script
SPIN_SH		:= $(CFG_DIR)/spinner.sh

# Message to display alongside the animation
SPIN_MSG	:= "Simulating compilation and linking for five seconds..."

# Create the file to stop the spinner (will be replaced by libmlx.a or something)
SPIN_FILE	:= "$(CFG_DIR)/.tmptestfile"

# spin time to stimulate duration (will be replaced by an other process)
PROCESS		:= sleep 5

spin:
	@$(REMOVE) $(SPIN_FILE)
	@echo "$(BOLD)$(PURPLE)Starting a long running task...$(RESET)"
	@$(SPIN_SH) $(SPIN_MSG) $(SPIN_FILE) &
	@$(PROCESS)
	@touch $(SPIN_FILE)
	@sleep 0.2
	@printf "$(UP)$(ERASE_LINE)"
	@echo "$(BOLD)$(GREEN)Long-running task completed.$(RESET)"
	@$(MAKE) spin2 $(NPD)


SPIN_MSG2	:= "Simulating something else for three seconds..."
PROCESS2	:= sleep 3

spin2:
	@$(REMOVE) $(SPIN_FILE)
	@echo "$(BOLD)$(PURPLE)Starting a shorter running task...$(RESET)"
	@$(SPIN_SH) $(SPIN_MSG2) $(SPIN_FILE) &
	@$(PROCESS2)
	@touch $(SPIN_FILE)
	@sleep 0.2
	@printf "$(UP)$(ERASE_LINE)"
	@echo "$(BOLD)$(GREEN)shorter task completed.$(RESET)"

.PHONY: spin spin2

# 

# choose:
# 	@echo "Select a project to clone:"
# 	@echo "1. libft"
# 	@echo "2. push_swap"
# 	@echo "3. FdF"
# 	@echo "4. pipex"
# 	@echo "5. Minishell"
# 	@echo "6. Cub3D"
# 	@echo "\n(tester projects)\n"
# 	@echo "7. Placeholder"
# 	@echo "8. minilibx_project"
# 	@echo "8. MLX_project"
# 	@read choice; \
# 	case $$choice in \
# 		1) echo "Cloning Project A..."; \
# 			git clone --recurse-submodules <project-A-repository-url> ;; \
# 		2) echo "Cloning Project B..."; \
# 			git clone --recurse-submodules <project-B-repository-url> ;; \
# 		3) echo "Cloning Project C..."; \
# 			git clone --recurse-submodules <project-C-repository-url> ;; \
# 		5) echo "Cloning Project C..."; \
# 		*) echo "Invalid choice. Exiting." ;; \
# 	esac

# .PHONY: choose

# **************************************************************************** #
# -------------------------------- MISC INFO --------------------------------- #
# **************************************************************************** #

# TOCHECK: Hyperlinks !!
# @echo "\033]8;;file://$(FILENAME)\a$(FILENAME)\033]8;;\a for results."

# TODO/TOCHECK?:
# replace L_FLAGS by LDFLAGS:
# Extra flags to give to compilers when they are supposed to invoke the linker,
# 'ld', such as -L.
# Non-library linker flags, such as -L, should go in the LDFLAGS variable.
# Libraries (-lfoo) should be added to the LDLIBS variable instead.

# Makefile variables explanations;
# https://www.gnu.org/software/make/manual/html_node/Implicit-Variables.html
# https://www.gnu.org/software/make/manual/html_node/Automatic-Variables.html
# https://www.gnu.org/software/make/manual/html_node/Implicit-Rules.html
# https://www.gnu.org/software/make/manual/html_node/Pattern-Examples.html
# https://www.gnu.org/software/make/manual/html_node/Text-Functions.html
# https://www.gnu.org/software/make/manual/html_node/File-Name-Functions.html
# https://www.gnu.org/software/make/manual/make.html#Conditionals
# https://www.gnu.org/software/make/manual/make.html#Conditional-Syntax

# ANSI escape codes;
# https://gist.github.com/fnky/458719343aabd01cfb17a3a4f7296797

# Image to ascii art;
# https://github.com/TheZoraiz/ascii-image-converter

# Text to ascii
# https://patorjk.com/ #(not secure, then choose text to ASCII art generator)
# 
# prefered fonts:	ANSI Regular, ANSI Shadow
