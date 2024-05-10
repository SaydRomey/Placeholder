# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: cdumais <cdumais@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/06/19 21:05:52 by cdumais           #+#    #+#              #
#    Updated: 2024/05/09 20:39:44 by cdumais          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# **************************************************************************** #
# --------------------------------- VARIABLES -------------------------------- #
# **************************************************************************** #
NAME		:= placeholder
AUTHOR		:= $(USER)
ARGS		:= # redefine in command line: 'make run ARGS=Makefile'
# override ARGS = infile.txt # this prevents redefining the 'ARGS' variable

CFG_DIR		:= .cfg
INC_DIR		:= inc
LIB_DIR		:= lib
OBJ_DIR		:= obj
SRC_DIR		:= src
TMP_DIR		:= tmp
WAV_DIR		:= wav

# https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html
# -Ofast	-> 
# -flto		-> link-time optimisation

COMPILE		:= gcc
OPTIMIZE	:= -Ofast -flto
DEBUG_FLAGS	:= -g
C_FLAGS		:= -Wall -Wextra -Werror $(OPTIMIZE)
L_FLAGS		:=
HEADERS		:= -I$(INC_DIR)

REMOVE		:= rm -rf
NPD			:= --no-print-directory
VOID		:= /dev/null
OS			:= $(shell uname)
USER		:= $(shell whoami)
TIME		:= $(shell date "+%H:%M:%S")
# **************************************************************************** #
# ---------------------------------- LIBFT ----------------------------------- #
# **************************************************************************** #
LIBFT_DIR	:= $(LIB_DIR)/libft
LIBFT_INC	:= $(LIBFT_DIR)/$(INC_DIR)
LIBFT		:= $(LIBFT_DIR)/libft.a
HEADERS		:= $(HEADERS) -I$(LIBFT_INC)
# **************************************************************************** #
# ----------------------------------- MLX ------------------------------------ #
# **************************************************************************** #
MLX_DIR		:= $(LIB_DIR)/MLX42
MLX_INC		:= $(MLX_DIR)/include/MLX42
MLX_BLD		:= $(MLX_DIR)/build
MLX42		:= $(MLX_BLD)/libmlx42.a

L_FLAGS		:= $(L_FLAGS) -L$(MLX_BLD) -lmlx42
HEADERS		:= $(HEADERS) -I$(MLX_INC)
# **************************************************************************** #
# ---------------------------------- CONFIG  --------------------------------- #
# **************************************************************************** #
# TODO: adapt default to desired dimensions in config_*.mk
# 
ifeq ($(OS),Linux)
include $(CFG_DIR)/config_linux.mk
else ifeq ($(OS),Darwin)
include $(CFG_DIR)/config_mac.mk
else
$(error Unsupported operating system: $(OS))
endif

C_FLAGS		+= -DWIDTH=$(SCREEN_W) -DHEIGHT=$(SCREEN_H)
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
# SRC		:=	
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
all: $(INIT) $(PIC) $(NAME)

$(NAME): $(MLX42) $(LIBFT) $(OBJS) $(INCS)
	@$(COMPILE) $(C_FLAGS) $(HEADERS) $(OBJS) $(LIBFT) $(L_FLAGS) -o $@
	@echo "$$TITLE"
	@echo "Compiled for $(ITALIC)$(BOLD)$(PURPLE)$(USER)$(RESET) \
		$(CYAN)$(TIME)$(RESET)\n"

$(LIBFT):
	@$(MAKE) -C $(LIBFT_DIR) $(NPD)

$(MLX42):
	@echo "Building MLX42..."
	@cmake -S lib/MLX42 -B lib/MLX42/build -Wno-dev
	@echo "Compiling MLX42..."
	@$(MAKE) -C lib/MLX42/build -j4 $(NPD)
	@echo "[$(BOLD)$(PURPLE)MLX42$(RESET)] \
	$(GREEN)\tbuilt successfully$(RESET)"

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c $(INCS) | $(OBJ_DIR)
	@echo "$(CYAN)Compiling...$(ORANGE)\t$(notdir $<)$(RESET)"
	@$(COMPILE) $(C_FLAGS) $(HEADERS) -c $< -o $@
	@printf "$(UP)$(ERASE_LINE)"

$(OBJ_DIR):
	@mkdir -p $(OBJ_DIR)

clean:
	@if [ -d "$(OBJ_DIR)" ]; then \
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
	@$(REMOVE) $(BONUS_CHECK) $(PIC_CHECK)
	@$(REMOVE) 

re: fclean all

.PHONY: all clean fclean re
# **************************************************************************** #
# ----------------------------------- MLX ------------------------------------ #
# **************************************************************************** #
# TODO: add the option to recompile MLX with debug flag in this section...
# 
mlxclean:
	@if [ -f $(MLX42) ]; then \
		$(REMOVE) $(MLX_BLD); \
		echo "[$(BOLD)$(PURPLE)MLX42$(RESET)] \
		$(GREEN)Library removed$(RESET)"; \
	else \
		echo "[$(BOLD)$(PURPLE)MLX42$(RESET)] \
		$(YELLOW)No library to remove$(RESET)"; \
	fi

mlxref:
	@$(OPEN) "https://github.com/codam-coding-college/MLX42/tree/master/docs"

.PHONY: mlxclean mlxref
# **************************************************************************** #
# ----------------------------------- GIT ------------------------------------ #
# **************************************************************************** #
init_submodules: $(INIT_CHECK)

WHEN	:= $(shell date "+On day %d of month %m in the year %Y at %H:%M and %S seconds")

$(INIT_CHECK):
	@git submodule update --init --recursive
	@echo "$(NAME)\n\
	by $(AUTHOR)\n\
	Compiled for $(USER)\n\
	$(WHEN)\n\
	$(MACHINE)" > $@

MAIN_BRANCH	:= $(shell git branch -r \
| grep -E 'origin/(main|master)' \
| grep -v 'HEAD' | head -n 1 | sed 's@^.*origin/@@')

update:
	@echo "Are you sure you want to update the repo and submodules? [y/N] " \
	&& read ANSWER; \
	if [ "$$ANSWER" = "y" ] || [ "$$ANSWER" = "Y" ]; then \
		echo "Updating repository from branch $(CYAN)$(MAIN_BRANCH)$(RESET)..."; \
		git pull origin $(MAIN_BRANCH); \
		$(MAKE) init_submodules; \
		echo "Repository updated."; \
	else \
		echo "Canceling update..."; \
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
# ---------------------------------- UTILS ----------------------------------- #
# **************************************************************************** #
include $(CFG_DIR)/leaks.mk

run: all
	@echo "$(GREEN)$(BOLD)./$(NAME) $(ARGS)$(RESET)\n"
	@./$(NAME) $(ARGS)

debug: C_FLAGS += $(DEBUG_FLAGS)
debug: re

$(TMP_DIR):
	@mkdir -p $(TMP_DIR)

ffclean: fclean vclean mlxclean
	@$(MAKE) fclean -C $(LIBFT_DIR) $(NPD)
	@$(REMOVE) $(TMP_DIR) $(INIT_CHECK) $(NAME).dSYM

FORCE_FLAGS	:= \
-Wno-unused-variable \
-Wno-unused-function

force: C_FLAGS += $(FORCE_FLAGS)
force: re
	@echo "adding flags $(YELLOW)$(FORCE_FLAGS)$(RESET)"
	@echo "$(RED)Forced compilation$(RESET)"
	./$(NAME) $(MAP)

.PHONY: run debug ffclean force
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
# **************************************************************************** # *!! put this in ./.cfg/osa.mk (included only if mac)
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
# **************************************************************************** #
# **************************************************************************** #
colortest:
	@for i in $$(seq 0 255); do \
		printf "\033[38;5;$$i;48;5;$$((i+1))m█$(RESET)"; \
	done

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


# **************************************************************************** #
# --------------------------------- SOUNDS ----------------------------------- #
# **************************************************************************** #
# https://sound-effects.bbcrewind.co.uk/
# https://soundbible.com/
# or convert youtube/mp3/etc. to .wav
# **************************************************************************** #
WAV_DESTROY	:= $(WAV_DIR)/destroy.wav

sound:
	@echo "testing a .wav sound"
	@$(SOUND) $(WAV_DESTROY)
	@echo "sound testing finished"

.PHONY: sound
# **************************************************************************** #
# ------------------------------- DEPENDENCIES  ------------------------------ #
# **************************************************************************** #
# TODO: automate this and place in proper submakefile...

# **************************************************************************** # Homebrew
CHECK_BREW := $(shell command -v brew 2> /dev/null)

brew:
ifndef CHECK_BREW
	@echo "Installing Homebrew..."
	curl -fsSL https://rawgit.com/kube/42homebrew/master/install.sh | zsh
else
	@echo "Homebrew is already installed, checking for updates..."
	@brew update
endif

delete_brew:
ifndef CHECK_BREW
	@echo "Homebrew not found"
else
	@echo "Removing Homebrew configuration lines from ~/.zshrc..."
	@sed -i '' \
		-e '/^# Load Homebrew Fix script/,/^source $$HOME\/.brewconfig.zsh/d' \
		~/.zshrc
	@echo "Homebrew configuration removed from ~/.zshrc."
	@echo "Deleting ~/.brewconfig.zsh file..."
	@rm -f ~/.brewconfig.zsh
	@echo "~/.brewconfig.zsh file deleted."
endif

brew_info:
	@open "https://docs.brew.sh/"
# **************************************************************************** # CMake
CHECK_BREW := $(shell command -v brew 2> /dev/null)
CHECK_CMAKE := $(shell command -v cmake 2> /dev/null)

# Estimated time (based on when i installed it on my session)
ESTIMATED_TIME = "$(BOLD)7 min 15 seconds$(RESET)"

cmake:
ifndef CHECK_BREW
	@echo "Brew is needed to install CMake... run 'make brew' first."
else
  ifndef CHECK_CMAKE
	@echo "Installing CMake...this might take around $(ESTIMATED_TIME)..."
	@brew install cmake
  else
	@echo "CMake is already installed."
  endif
endif
# **************************************************************************** # GLFW
CHECK_GLFW := $(shell command -v glfw 2> /dev/null)

# Estimated time (based on when i installed it on my session)
ESTIMATED_TIME = "$(BOLD)10 seconds$(RESET)"

glfw:
ifndef CHECK_BREW
	@echo "Brew is needed to install GLFW... run 'make brew' first."
else
  ifndef CHECK_GLFW
	@echo "Installing GLFW...this might take around $(ESTIMATED_TIME)"
	@brew install glfw
  else
	@echo "GLFW is already installed."
  endif
endif

.PHONY: brew delete_brew brew_info cmake glfw
