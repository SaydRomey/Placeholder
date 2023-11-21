# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: cdumais <cdumais@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/06/19 21:05:52 by cdumais           #+#    #+#              #
#    Updated: 2023/11/21 12:13:52 by cdumais          ###   ########.fr        #
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

LIBFT_DIR	:= $(LIB_DIR)/libft
LIBFT_INC	:= $(LIBFT_DIR)/$(INC_DIR)
LIBFT_HDR	:= $(LIBFT_INC)/libft.h
LIBFT_SRCS	:= $(wildcard $(LIBFT_DIR)/$(SRC_DIR)/*.c)
LIBFT		:= $(LIBFT_DIR)/libft.a

COMPILE		:= gcc
C_FLAGS		:= -Wall -Wextra -Werror

REMOVE		:= rm -rf
NPD			:= --no-print-directory
VOID		:= /dev/null

HEADERS 	:= -I$(INC_DIR) -I$(LIBFT_INC)
# LDFLAGS		:= 
# **************************************************************************** #
# --------------------------------- C FILES ---------------------------------- #
# **************************************************************************** #
# SRC		:=
# **************************************************************************** #

# **************************************************************************** #
# --------------------------------- H FILES ---------------------------------- #
# **************************************************************************** #
# INC		:=
# **************************************************************************** #
# -------------------------------- ALL FILES --------------------------------- #
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
all: $(NAME)

$(NAME): $(LIBFT) $(OBJS) $(INCS)
	@echo "[$(BOLD)$(PURPLE)$(NAME)$(RESET)]\\t$(GREEN)created$(RESET)"
	@echo "$(GREEN)$$TITLE$(RESET)"
	@echo "Compiled for $(ITALIC)$(BOLD)$(PURPLE)$(USER)$(RESET) \
		$(CYAN)$(TIME)$(RESET)\n"
	@$(COMPILE) $(C_FLAGS) $(HEADERS) $(OBJS) $(LIBFT) -o $@

$(LIBFT): $(LIBFT_SRCS) $(LIBFT_HDR)
	@make -C $(LIBFT_DIR) $(NPD)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c $(INCS) | $(OBJ_DIR)
	@echo "$(CYAN)Compiling...$(ORANGE)\t$(notdir $<)$(RESET)"
	@$(COMPILE) $(C_FLAGS) $(HEADERS) -c $< -o $@
	@printf "$(UP)$(ERASE_LINE)"

$(OBJ_DIR):
	@mkdir -p $(OBJ_DIR)

clean:
	@if [ -n "$(wildcard $(OBJ_DIR))" ]; then \
		$(REMOVE) $(OBJ_DIR); \
		echo "[$(BOLD)$(PURPLE)$(NAME)$(RESET)] \
		$(GREEN)Object files removed$(RESET)"; \
	else \
		echo "[$(BOLD)$(PURPLE)$(NAME)$(RESET)] \
		$(YELLOW)No object files to remove$(RESET)"; \
	fi
	@make clean -C $(LIBFT_DIR) $(NPD)

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
# ---------------------------------- UTILS ----------------------------------- #
# **************************************************************************** #
run: all
	@./$(NAME) $(ARGS)

debug: C_FLAGS += -g
debug: re
# @./$(NAME)
# **************************************************************************** #
# ---------------------------------- NORME ----------------------------------- #
# **************************************************************************** #
norm:
	@if which norminette > $(VOID); then \
		echo "$(BOLD)$(YELLOW)Norminetting $(PURPLE)$(NAME)$(RESET)"; \
		norminette -o $(INCS); \
		norminette -o $(SRCS); \
		make norm -C $(LIBFT_DIR); \
	else \
		echo "$(BOLD)$(YELLOW)Norminette not installed$(RESET)"; \
	fi

nm: $(NAME)
	@echo "$(BOLD)$(YELLOW)Functions in $(PURPLE)$(UNDERLINE)$(NAME)$(RESET):"
	@nm $(NAME) | grep U | grep -v 'ft_' \
				| sed 's/U//g' | sed 's/__//g' | sed 's/ //g' \
				| sort | uniq
	@make nm -C $(LIBFT_DIR) $(NPD)

.PHONY: norm nm
# **************************************************************************** #
# ---------------------------------- BACKUP ---------------------------------- #
# **************************************************************************** #
USER		:=$(shell whoami)
ROOT_DIR	:=$(notdir $(shell pwd))
TIMESTAMP	:=$(shell date "+%Y%m%d_%H%M%S")
BACKUP_NAME	:=$(ROOT_DIR)_$(USER)_$(TIMESTAMP).zip
MOVE_TO		:= ~/Desktop/$(BACKUP_NAME)

backup: ffclean
	@if which zip > $(VOID); then \
		zip -r --quiet $(BACKUP_NAME) ./*; \
		mv $(BACKUP_NAME) $(MOVE_TO); \
		echo "[$(BOLD)$(PURPLE)$(NAME)$(RESET)] \
		compressed as: $(CYAN)$(UNDERLINE)$(MOVE_TO)$(RESET)"; \
	else \
		echo "Please install zip to use the backup feature"; \
	fi

.PHONY: backup
# **************************************************************************** #
# -------------------------------- LEAKS ------------------------------------- #
# **************************************************************************** #
VAL_CHECK	:= $(shell which valgrind > $(VOID); echo $$?)

# valgrind options
VAL_LOG		:= valgrind-out.txt
ORIGIN		:= --track-origins=yes
LEAK_CHECK	:= --leak-check=full
LEAK_KIND	:= --show-leak-kinds=all
CHILDREN	:= --trace-children=yes
FD_TRACK	:= --track-fds=yes
NO_REACH	:= --show-reachable=no
VERBOSE		:= --verbose
LOG_FILE	:= --log-file=$(VAL_LOG)

# suppression-related options
SUPP_FILE	:= suppression.supp
SUPP_GEN	:= --gen-suppressions=all
SUPPRESS	:= --suppressions=$(SUPP_FILE)

# default valgrind tool
BASE_TOOL = valgrind $(ORIGIN) $(LEAK_CHECK) $(LEAK_KIND)

# specific valgrind tool (change options as needed)
BASE_TOOL += $(CHILDREN) $(FD_TRACK)

LEAK_TOOL = $(BASE_TOOL) $(LOG_FILE)
SUPP_TOOL = $(BASE_TOOL) $(SUPP_GEN) $(LOG_FILE)

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
		echo "Please install valgrind to use the leaks feature"; \
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

.PHONY: leaks supp suppleaks vclean
# **************************************************************************** #
ffclean: fclean vclean
	@$(REMOVE) $(NAME).dSYM

.PHONY: ffclean
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
ESC			:= \e

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
