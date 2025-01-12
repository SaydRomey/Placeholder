
# Project info
NAME		:= ircserv
AUTHOR		:= cdumais
REPO_LINK	:= https://github.com/SaydRomey/

# Build configuration
COMPILE		:= gcc
C_FLAGS		:= -Wall -Wextra -Werror

# Source code files
SRC_DIR		:= src
# SRC			:= # (add .c files without ".c" to explicitely list them...)
# SRCS		:= $(addprefix $(SRC_DIR)/, $(addsuffix .c, $(SRC)))
SRCS		:= $(shell find $(SRC_DIR) -name "*.c")
# SRCS		:= $(wildcard $(SRC_DIR)/*.c)

# Object files
OBJ_DIR		:= obj
OBJS		:= $(SRCS:$(SRC_DIR)/%.c=$(OBJ_DIR)/%.o)
# OBJS		:= $(patsubst $(SRC_DIR)/%.c,$(OBJ_DIR)/%.o,$(SRCS))

# Header files
INC_DIR		:= inc
# INC			:= # (add .h file without ".h" to explicitely list them...)
# HEADERS		:= $(addprefix $(INC_DIR)/, $(addsuffix .h, $(INC)))
HEADERS		:= $(shell find $(INC_DIR) -name "*.h")
# HEADERS		:= $(wildcard $(INC_DIR)/*.h)
INCLUDES	:= $(addprefix -I, $(shell find $(INC_DIR) -type d))

# Libraries
LIB_DIR		:= lib
L_FLAGS		:=

# Libft
LIBFT_DIR	:= $(LIB_DIR)/libft
LIBFT_INC	:= $(LIBFT_DIR)/$(INC_DIR)
LIBFT		:= $(LIBFT_DIR)/libft.a
HEADERS		:= $(HEADERS) -I$(LIBFT_INC)

# Tools and Configuration
CFG_DIR		:= cfg

# Helper makefiles
MAKE_DIR	:= ./$(CFG_DIR/makefiles

include $(MAKE_DIR)/utils.mk	# Utility Variables and Macros
# include $(MAKE_DIR)/

# ==============================
##@ 🎯 Compilation
# ==============================

.DEFAULT_GOAL	:= all

.DEFAULT:
	$(info make: *** No rule to make target '$(MAKECMDGOALS)'.  Stop.)
	@$(MAKE) help $(NPD)

all: $(INIT) $(NAME) ## Buld the project

$(NAME): $(MLX42) $(LIBFT) $(OBJS)
	@$(COMPILE) $(C_FLAGS) $(OBJS) $(INCLUDES) $(LIBFT) $(L_FLAGS) -o $@
	@$(call SUCCESS,$@,Build complete)

$(LIBFT):
	@$(MAKE) -C $(LIBFT_DIR) $(NPD)

$(MLX42):
	@echo "Building MLX42..."
	@cmake -S lib/MLX42 -B lib/MLX42/build -Wno-dev
	@echo "Compiling MLX42..."
	@$(MAKE) -C lib/MLX42/build -j4 $(NPD)
	@$(call SUCCESS,$@,Build complete)

# Object compilation rules
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c $(HEADERS)
	@mkdir -p $(@D)
	@$(call INFO,$(NAME),$(ORANGE)Compiling...\t,$(CYAN)$(notdir $<))
	@$(COMPILE) $(C_FLAGS) $(INCLUDES) -c $< -o $@
	@$(call UPCUT)

# ==============================
##@ 🧹 Cleanup
# ==============================

clean: ## Remove object files
	@$(call CLEANUP,$(NAME),object files,$(OBJ_DIR))
	@$(call CLEANUP,$(Libft),object files,$(LIBFT_DIR)/$(OBJ_DIR))
# @$(MAKE) clean -C $(LIBFT_DIR) $(NPD)

fclean: clean ## Remove executable
	@$(call CLEANUP,$(NAME),executable,$(NAME))
	@$(call CLEANUP,$(Libft),library,$(LIBFT))
# @$(MAKE) fclean -C $(LIBFT_DIR) $(NPD)

# vclean mlxclean
ffclean: fclean ## Remove all generated files and folders
	@$(MAKE) pdf-clean $(NPD)
	@$(REMOVE) $(INIT_CHECK)

re: fclean all ## Rebuild everything

.PHONY: all clean fclean ffclean re

# ==============================
##@ 🚀 Execution
# ==============================

run: all ## Compile and run the executable
	@$(call INFO,$(NAME),,./$(NAME))
	@./$(NAME)

.PHONY: run

# ==============================
##@ 🛠  Utility
# ==============================

help: ## Display available targets
	@echo "\nAvailable targets:"
	@awk 'BEGIN {FS = ":.*##";} \
		/^[a-zA-Z_0-9-]+:.*?##/ { \
			printf "   $(CYAN)%-15s$(RESET) %s\n", $$1, $$2 \
		} \
		/^##@/ { \
			printf "\n$(BOLD)%s$(RESET)\n", substr($$0, 5) \
		}' $(MAKEFILE_LIST)

repo: ## Open the GitHub repository
	@$(call INFO,$(NAME),Opening $(AUTHOR)'s github repo...)
	@open $(REPO_LINK);

.PHONY: help repo
