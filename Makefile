# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: cdumais <cdumais@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/06/19 21:05:52 by cdumais           #+#    #+#              #
#    Updated: 2024/01/09 20:11:37 by cdumais          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# **************************************************************************** #
# --------------------------------- VARIABLES -------------------------------- #
# **************************************************************************** #
NAME		:= placeholder
ARGS		:= # redefine in command line: 'make run ARGS=Makefile'
# override ARGS = infile.txt # this prevents redefining the 'ARGS' variable

INC_DIR		:= inc
LIB_DIR		:= lib
OBJ_DIR		:= obj
SRC_DIR		:= src
TMP_DIR		:= tmp

COMPILE		:= gcc
C_FLAGS		:= -Wall -Wextra -Werror
HEADERS		:= -I$(INC_DIR)

REMOVE		:= rm -rf
NPD			:= --no-print-directory
VOID		:= /dev/null
OS			:= $(shell uname -s)
# **************************************************************************** #
# ---------------------------------- LIBFT ----------------------------------- #
# **************************************************************************** #
LIBFT_DIR	:= $(LIB_DIR)/libft
LIBFT_INC	:= $(LIBFT_DIR)/$(INC_DIR)
LIBFT		:= $(LIBFT_DIR)/libft.a
HEADERS		:= $(HEADERS) -I$(LIBFT_INC)
# **************************************************************************** #
# -------------------------------- MINILIBX (variables) ---------------------- #
# **************************************************************************** #
# MLX_DIR		:= $(LIB_DIR)/minilibx

# ifeq ($(OS), Linux)
# 	C_FLAGS	:= $(CFLAGS) -D OS=$(OS) #(check if this works better) ?
# 	END_SRC := cleanup_linux.c
# 	MLX_DIR := $(MLX_DIR)/minilibx_linux
# 	L_FLAGS := -L$(MLX_DIR) -lmlx -lbsd -lXext -lX11 -lm
# else ifeq ($(OS), Darwin)
# 	END_SRC := cleanup_mac.c
# 	MLX_DIR := $(MLX_DIR)/minilibx_macos
# 	L_FLAGS := -L$(MLX_DIR) -lmlx -framework OpenGL -framework AppKit
# else
# 	$(error Unsupported operating system: $(UNAME))
# endif

# MLX			:= $(MLX_DIR)/libmlx.a
# HEADERS		:= $(HEADERS) -I$(MLX_DIR)
# **************************************************************************** #
# -------------------------------- SUBMODULES  ------------------------------- #
# **************************************************************************** #
INIT_CHECK	:= $(LIB_DIR)/.init_check
INIT		:= $(if $(wildcard $(INIT_CHECK)),,init_submodules)
# **************************************************************************** #
# --------------------------------- H FILES ---------------------------------- #
# **************************************************************************** #
# INC		:= 
# **************************************************************************** #
# --------------------------------- C FILES ---------------------------------- #
# **************************************************************************** #
# SRC		:=	$(END_SRC)
# **************************************************************************** #
# -------------------------------- ALL FILES --------------------------------- #
# **************************************************************************** #
# INCS		:=	$(addprefix $(INC_DIR)/, $(addsuffix .h, $(INC)))
# SRCS		:=	$(addprefix $(SRC_DIR)/, $(addsuffix .c, $(SRC)))
# OBJS		:=	$(patsubst $(SRC_DIR)/%.c,$(OBJ_DIR)/%.o,$(SRCS))
# **************************************************************************** #
# -------------------------------- ALL * FILES ------------------------------- #
# **************************************************************************** #
# INCS		:=	$(addprefix $(INC_DIR)/, $(addsuffix .h, $(INC)))
# SRCS		:=	$(addprefix $(SRC_DIR)/, $(addsuffix .c, $(SRC)))
# OBJS		:=	$(patsubst $(SRC_DIR)/%.c,$(OBJ_DIR)/%.o,$(SRCS))
# **************************************************************************** #
# -------------------------------- ALL * FILES ------------------------------- #
# **************************************************************************** #
INCS		:=	$(wildcard $(INC_DIR)/*.h)
SRCS		:=	$(wildcard $(SRC_DIR)/*.c)
OBJS		:=	$(patsubst $(SRC_DIR)/%.c,$(OBJ_DIR)/%.o,$(SRCS))
# **************************************************************************** #
# ---------------------------------- RULES ----------------------------------- #
# **************************************************************************** #
all: $(INIT) $(NAME)

# $(NAME): $(LIBFT) $(OBJS) $(INCS) $(MLX)
$(NAME): $(LIBFT) $(OBJS) $(INCS)
	@echo "[$(BOLD)$(PURPLE)$(NAME)$(RESET)]\\t$(GREEN)created$(RESET)"
	@echo "$(GREEN)$$TITLE$(RESET)"
	@echo "Compiled for $(ITALIC)$(BOLD)$(PURPLE)$(USER)$(RESET) \
		$(CYAN)$(TIME)$(RESET)\n"
	@$(COMPILE) $(C_FLAGS) $(HEADERS) $(OBJS) $(LIBFT) -o $@
# @$(COMPILE) $(C_FLAGS) $(HEADERS) $(OBJS) $(LIBFT) $(L_FLAGS) -o $@

$(LIBFT):
	@$(MAKE) -C $(LIBFT_DIR) $(NPD)

# $(MLX):
# 	@echo "Building minilibx in $(CYAN)$(UNDERLINE)$(MLX_DIR)$(RESET)..."
# 	@$(MAKE) -C $(MLX_DIR) > $(VOID) 2>&1 || \
# 		(echo "Failed to build minilibx in $(MLX_DIR)" && exit 1)
# 	@printf "$(UP)$(ERASE_LINE)"
# 	@echo "[$(BOLD)$(PURPLE)minilibx$(RESET)] \
# 	$(GREEN)\tbuilt successfully$(RESET)"

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c $(INCS) | $(OBJ_DIR)
	@echo "$(CYAN)Compiling...$(ORANGE)\t$(notdir $<)$(RESET)"
	@$(COMPILE) $(C_FLAGS) $(HEADERS) -c $< -o $@
	@printf "$(UP)$(ERASE_LINE)"

$(OBJ_DIR):
	@mkdir -p $(OBJ_DIR)

# @if [ -d "$(OBJ_DIR)" ]; then
clean:
	@if [ -n "$(wildcard $(OBJ_DIR))" ]; then \
		$(REMOVE) $(OBJ_DIR); \
		echo "[$(BOLD)$(PURPLE)$(NAME)$(RESET)] \
		$(GREEN)Object files removed$(RESET)"; \
	else \
		echo "[$(BOLD)$(PURPLE)$(NAME)$(RESET)] \
		$(YELLOW)No object files to remove$(RESET)"; \
	fi
	@$(MAKE) clean -C $(LIBFT_DIR) $(NPD)

fclean: clean
	@if [ -n "$(wildcard $(NAME))" ]; then \
		$(REMOVE) $(NAME); \
		echo "[$(BOLD)$(PURPLE)$(NAME)$(RESET)] \
		$(GREEN)Executable removed$(RESET)"; \
	else \
		echo "[$(BOLD)$(PURPLE)$(NAME)$(RESET)] \
		$(YELLOW)No executable to remove$(RESET)"; \
	fi
	@if [ -n "$(wildcard $(LIBFT))" ]; then \
		$(REMOVE) $(LIBFT); \
		echo "[$(BOLD)$(PURPLE)$(notdir $(LIBFT))$(RESET)] \
		$(GREEN)$(notdir $(LIBFT)) removed$(RESET)"; \
	else \
		echo "[$(BOLD)$(PURPLE)$(notdir $(LIBFT))$(RESET)] \
		$(YELLOW)No library to remove$(RESET)"; \
	fi

re: fclean all

.PHONY: all clean fclean re
# **************************************************************************** #
# -------------------------------- MINILIBX ---------------------------------- #
# **************************************************************************** #
# mlxclean:
# 	@if [ -f $(MLX) ]; then \
# 		make clean -C $(MLX_DIR) > $(VOID) 2>&1 || (echo "mlx clean error" \
# 			&& exit 1); \
# 		echo "[$(BOLD)$(PURPLE)minilibx$(RESET)] \
# 		$(GREEN)Library removed$(RESET)"; \
# 	else \
# 		echo "[$(BOLD)$(PURPLE)minilibx$(RESET)] \
# 		$(YELLOW)No library to remove$(RESET)"; \
# 	fi

# .PHONY: mlxclean
# **************************************************************************** #
# ----------------------------------- GIT ------------------------------------ #
# **************************************************************************** #
init_submodules: $(INIT_CHECK)

$(INIT_CHECK):
	@git submodule update --init --recursive
	@touch $@

# ifeq ($(OS), Linux)
# 	@chmod +x $(MLX_DIR)/configure
# endif

update:
	@echo "Are you sure you want to update the repo and submodules? [y/N] " \
	&& read ANSWER; \
	if [ "$$ANSWER" = "y" ] || [ "$$ANSWER" = "Y" ]; then \
		git pull origin main; \
		$(MAKE) init_submodules; \
		echo "Repository and submodules updated."; \
	else \
		echo "canceling update..."; \
	fi

.PHONY: init_submodules update
# **************************************************************************** #
# ---------------------------------- NORME ----------------------------------- #
# **************************************************************************** #
norm:
	@if which norminette > $(VOID); then \
		echo "$(BOLD)$(YELLOW)Norminetting $(PURPLE)$(NAME)$(RESET)"; \
		norminette -o $(INCS); \
		norminette -o $(SRCS); \
		$(MAKE) norm -C $(LIBFT_DIR); \
	else \
		echo "$(BOLD)$(YELLOW)Norminette not installed$(RESET)"; \
	fi

nm: $(NAME)
	@echo "$(BOLD)$(YELLOW)Functions in $(PURPLE)$(UNDERLINE)$(NAME)$(RESET):"
	@nm $(NAME) | grep U | grep -v 'ft_' \
				| sed 's/U//g' | sed 's/__//g' | sed 's/ //g' \
				| sort | uniq
	@$(MAKE) nm -C $(LIBFT_DIR) $(NPD)

.PHONY: norm nm
# **************************************************************************** #
# ---------------------------------- PDF ------------------------------------- #
# **************************************************************************** #
PDF		:= cub3d_en.pdf
GIT_URL	:= https://github.com/SaydRomey/42_ressources
PDF_URL	= $(GIT_URL)/blob/main/pdf/$(PDF)?raw=true

pdf: | $(TMP_DIR)
	@curl -# -L $(PDF_URL) -o $(TMP_DIR)/$(PDF)
ifeq ($(OS),Darwin)
	@open $(TMP_DIR)/$(PDF)
else
	@xdg-open $(TMP_DIR)/$(PDF) || echo "Please install a compatible PDF viewer"
endif

.PHONY: pdf
# **************************************************************************** #
# -------------------------------- LEAKS ------------------------------------- #
# **************************************************************************** #
VAL_CHECK	:= $(shell which valgrind > $(VOID); echo $$?)

# valgrind options
ORIGIN		:= --track-origins=yes
LEAK_CHECK	:= --leak-check=full
LEAK_KIND	:= --show-leak-kinds=all

# valgrind additional options
CHILDREN	:= --trace-children=yes
FD_TRACK	:= --track-fds=yes
HELGRIND	:= --tool=helgrind
NO_REACH	:= --show-reachable=no
VERBOSE		:= --verbose
VAL_LOG		:= valgrind-out.txt
LOG_FILE	:= --log-file=$(VAL_LOG)

# suppression-related options
SUPP_FILE	:= suppression.supp
SUPP_GEN	:= --gen-suppressions=all
SUPPRESS	:= --suppressions=$(SUPP_FILE)

# default valgrind tool
BASE_TOOL	= valgrind $(ORIGIN) $(LEAK_CHECK) $(LEAK_KIND)
# **************************************************************************** #
# specific valgrind tool (add 'valgrind option' variables as needed)
BASE_TOOL	+= 
# **************************************************************************** #	TODO: check if we should put messages as an echo instead of a target
LEAK_TOOL	= $(BASE_TOOL) $(LOG_FILE)
SUPP_TOOL	= $(BASE_TOOL) $(SUPP_GEN) $(LOG_FILE)

# run valgrind
leaks_msg:
	@echo "[$(BOLD)$(PURPLE)valgrind$(RESET)] \
	$(ORANGE)\tRecompiling with debug flags$(RESET)"

leaks: leaks_msg debug
	@if [ $(VAL_CHECK) -eq 0 ]; then \
		echo "[$(BOLD)$(PURPLE)valgrind$(RESET)] \
		$(ORANGE)Launching valgrind\n$(RESET)#"; \
		$(LEAK_TOOL) ./$(NAME) $(ARGS); \
		echo "#\n[$(BOLD)$(PURPLE)valgrind$(RESET)] \
		$(ORANGE)info in: $(CYAN)$(VAL_LOG)$(RESET)"; \
	else \
		echo "Please install valgrind to use the 'leaks' feature"; \
	fi

# generate suppression file
supp_msg:
	@echo "generating suppression file"
supp: leaks_msg supp_msg debug
	$(SUPP_TOOL) ./$(NAME) $(ARGS) && \
	awk '/^{/,/^}/' valgrind-out.txt > suppression.supp

# use suppression file
suppleaks_msg:
	@echo "launching valgrind with suppression file"
suppleaks: debug
	$(LEAK_TOOL) $(SUPPRESS) ./$(NAME) $(ARGS)

# remove suppression and log files
vclean:
	@if [ -n "$(wildcard suppression.supp)" ]; then \
		$(REMOVE) $(SUPP_FILE); \
		echo "[$(BOLD)$(PURPLE)$(NAME)$(RESET)] \
		$(GREEN)suppression file removed$(RESET)"; \
	else \
		echo "[$(BOLD)$(PURPLE)$(NAME)$(RESET)] \
		$(YELLOW)no suppression file to remove$(RESET)"; \
	fi
	@if [ -n "$(wildcard valgrind-out.txt)" ]; then \
		$(REMOVE) valgrind-out.txt; \
		echo "[$(BOLD)$(PURPLE)$(NAME)$(RESET)] \
		$(GREEN)log file removed$(RESET)"; \
	else \
		echo "[$(BOLD)$(PURPLE)$(NAME)$(RESET)] \
		$(YELLOW)no log file to remove$(RESET)"; \
	fi

.PHONY: leaks_msg leaks supp_msg supp suppleaks_msg suppleaks vclean
# **************************************************************************** #
# ---------------------------------- UTILS ----------------------------------- #
# **************************************************************************** #
run: all
	./$(NAME) $(ARGS)

debug: C_FLAGS += -g
debug: re

$(TMP_DIR):
	@mkdir -p $(TMP_DIR)

# ffclean: fclean vclean mlxclean
ffclean: fclean vclean
	@$(MAKE) fclean -C $(LIBFT_DIR) $(NPD)
	@$(REMOVE) $(TMP_DIR) $(INIT_CHECK) $(NAME).dSYM

.PHONY: run debug ffclean
# **************************************************************************** #
# ---------------------------------- BACKUP (zip) ---------------------------- #
# **************************************************************************** #
USER		:=$(shell whoami)
ROOT_DIR	:=$(notdir $(shell pwd))
TIMESTAMP	:=$(shell date "+%Y%m%d_%H%M%S")
BACKUP_NAME	:=$(ROOT_DIR)_$(USER)_$(TIMESTAMP).zip
MOVE_TO		:= ~/Desktop/$(BACKUP_NAME)

zip: ffclean
	@if which zip > $(VOID); then \
		zip -r --quiet $(BACKUP_NAME) ./*; \
		mv $(BACKUP_NAME) $(MOVE_TO); \
		echo "[$(BOLD)$(PURPLE)$(NAME)$(RESET)] \
		compressed as: $(CYAN)$(UNDERLINE)$(MOVE_TO)$(RESET)"; \
	else \
		echo "Please install zip to use the backup feature"; \
	fi

.PHONY: zip
# **************************************************************************** #
# ------------------------------- DECORATIONS -------------------------------- #
# **************************************************************************** #
define TITLE

***************
* PLACEHOLDER *
***************

endef
export TITLE

USER		:=$(shell whoami)
TIME		:=$(shell date "+%H:%M:%S")

title:
	@echo "$(BOLD)$(PURPLE)$(NAME)$(GREEN) created$(RESET)"
	@echo "$(GREEN)$$TITLE$(RESET)"
	@echo "Compiled for $(ITALIC)$(BOLD)$(PURPLE)$(USER)$(RESET) \
		$(CYAN)$(TIME)$(RESET)\n"

.PHONY: title
# **************************************************************************** #
# ----------------------------------- ANSI ----------------------------------- #
# **************************************************************************** #
ESC			:= \033

RESET		:= $(ESC)[0m
BOLD		:= $(ESC)[1m
DIM			:= $(ESC)[2m
ITALIC		:= $(ESC)[3m
UNDERLINE	:= $(ESC)[4m
BLINK		:= $(ESC)[5m #no effect on iterm?
INVERT		:= $(ESC)[7m
HIDDEN		:= $(ESC)[8m
STRIKE		:= $(ESC)[9m

# Cursor movement
UP			:= $(ESC)[A
DOWN		:= $(ESC)[B
FORWARD		:= $(ESC)[C
BACK		:= $(ESC)[D
NEXT_LINE	:= $(ESC)[E
PREV_LINE	:= $(ESC)[F
COLUMN		:= $(ESC)[G
TOP_LEFT	:= $(ESC)[1;1H

# Erasing
ERASE_REST	:= $(ESC)[K
ERASE_LINE	:= $(ESC)[2K
ERASE_ALL	:= $(ESC)[2J
# **************************************************************************** #
# ---------------------------------- COLORS ---------------------------------- #
# **************************************************************************** #
# Text
BLACK		:= $(ESC)[30m
RED			:= $(ESC)[91m
GREEN		:= $(ESC)[32m
YELLOW		:= $(ESC)[93m
ORANGE		:= $(ESC)[38;5;208m
BLUE		:= $(ESC)[94m
PURPLE		:= $(ESC)[95m
CYAN		:= $(ESC)[96m
WHITE		:= $(ESC)[37m
GRAY		:= $(ESC)[90m

# Background
BG_BLACK	:= $(ESC)[40m
BG_RED		:= $(ESC)[101m
BG_GREEN	:= $(ESC)[102m
BG_YELLOW	:= $(ESC)[103m
BG_ORANGE	:= $(ESC)[48;5;208m
BG_BLUE		:= $(ESC)[104m
BG_PURPLE	:= $(ESC)[105m
BG_CYAN		:= $(ESC)[106m
BG_WHITE	:= $(ESC)[47m
BG_GRAY		:= $(ESC)[100m
# **************************************************************************** #
# ---------------------------------- TESTS ----------------------------------- #
# **************************************************************************** #
# testing multiple option targets
# (add grademe ?)

choose_read:
	@echo "Are you sure you want to print \"testing\" [y/N] " && read ANSWER; \
	if [ "$$ANSWER" = "y" ] || [ "$$ANSWER" = "Y" ]; then \
		echo "testing"; \
	else \
		echo "canceling..."; \
	fi

choose_case:
	@echo "Select a project to clone:"
	@echo "1. Project A"
	@echo "2. Project B"
	@echo "3. Project C"
	@read choice; \
	case $$choice in \
		1) echo "Cloning Project A..."; \
			echo "AAAAA" ;; \
		2) echo "Cloning Project B..."; \
			echo "BBBBB" ;; \
		3) echo "Cloning Project C..."; \
			echo "CCCCC" ;; \
		*) echo "Invalid choice. Exiting." ;; \
	esac

.PHONY: choose_read choose_case

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

define BEAR
   _     _   
  (c).-.(c)  
   / ._. \   
 __\( Y )/__ 
(_.-/'-'\-._)
   ||   ||   
 _.' `-' '._ 
(.-./`-'\.-.)
 `-'     `-' 

endef
export BEAR

bear:
	@echo "$$BEAR"
# **************************************************************************** #
# -------------------------------- OSASCRIPT --------------------------------- #
# **************************************************************************** #
OSA =  osascript -e

ITERM = tell application "iTerm"
SET_SCR = to tell current window to set bounds to # L, T, R, B
WRITE = to tell current session of current window to write text

SYS_EV = tell application "System Events"
HIDE_DOCK = to set the autohide of the dock preferences to true
SHOW_DOCK = to set the autohide of the dock preferences to false

# # screen limits
SCR_L = 0
SCR_TOP = 0
SCR_R = 2560
SCR_BTM = 1440

# # midpoints
LR = 1280
TB = 708

# # default dock (at bottom) coord
DOCK_L = 635
DOCK_R = 1925
DOCK_T = 1335

nodock:
	@$(OSA) '$(SYS_EV) $(HIDE_DOCK)'

yesdock:
	@$(OSA) '$(SYS_EV) $(SHOW_DOCK)'

rightscreen:
	@$(OSA) '$(ITERM) $(SET_SCR) {$(DOCK_R), $(SCR_TOP), $(SCR_R), $(SCR_BTM)}'

centerscreen:
	@$(OSA) '$(SYS_EV) $(SHOW_DOCK)'
	@$(OSA) '$(ITERM) $(SET_SCR) {665, 100, 1985, 1275}'

middlescreen:
	@$(OSA) '$(ITERM) $(SET_SCR) {$(DOCK_L), $(SCR_TOP), $(DOCK_R), $(SCR_BTM)}'

fullscreen:
	@$(OSA) '$(SYS_EV) $(HIDE_DOCK)'
	@$(OSA) '$(ITERM) $(SET_SCR) {$(SCR_L), $(SCR_TOP), $(SCR_R), $(SCR_BTM)}'

bearscreen:
	@$(OSA) '$(ITERM) $(SET_SCR) {$(LR)-160, $(TB)-160, $(LR)+160, $(TB)+160}' \
	-e '$(ITERM) $(WRITE) "clear && make bear"'

hide_dock:
	@osascript -e 'tell application "System Events" to \
	set the autohide of the dock preferences to true'

show_dock:
	@osascript -e 'tell application "System Events" to \
	set the autohide of the dock preferences to false'


# **************************************************************************** #
colortest:
	@for i in $$(seq 0 255); do \
		printf "\033[38;5;$$i;48;5;$$((i+1))m█$(RESET)"; \
	done

# **************************************************************************** #
# -------------------------------- MISC INFO --------------------------------- #
# **************************************************************************** #
# 
# Makefile variables explanations;
# https://www.gnu.org/software/make/manual/html_node/Implicit-Variables.html
# https://www.gnu.org/software/make/manual/html_node/Automatic-Variables.html
# https://www.gnu.org/software/make/manual/html_node/Implicit-Rules.html
# https://www.gnu.org/software/make/manual/html_node/Pattern-Examples.html
# https://www.gnu.org/software/make/manual/html_node/Text-Functions.html
# https://www.gnu.org/software/make/manual/html_node/File-Name-Functions.html
# 
# ANSI escape codes;
# https://gist.github.com/fnky/458719343aabd01cfb17a3a4f7296797
# 
# Image to ascii art;
# https://github.com/TheZoraiz/ascii-image-converter
# 
# Text to ascii
# https://patorjk.com/ #(not secure, then choose text to ASCII art generator)
# 
# prefered fonts:	ANSI Regular, ANSI Shadow
