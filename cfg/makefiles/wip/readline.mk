
# LIB_DIR		:= lib

# **************************************************************************** #
# -------------------------------- READLINE (variables) ---------------------- #
# **************************************************************************** #
READLINE_DIR			:= $(LIB_DIR)/readline
READLINE_SRC_URL		:= https://ftp.gnu.org/gnu/readline/readline-8.2.tar.gz
READLINE_SRC			:= $(READLINE_DIR)/readline-8.2.tar.gz
READLINE_BUILD_DIR		:= $(READLINE_DIR)/src
READLINE_INSTALL_DIR	:= $(READLINE_DIR)/install
READLINE_SENTINEL		:= $(READLINE_DIR)/.installed

HEADERS += -I$(READLINE_INSTALL_DIR)/include
LDFLAGS += -L$(READLINE_INSTALL_DIR)/lib -lreadline -lncurses

READLINE_DEP := $(if $(wildcard $(READLINE_SENTINEL)),,install_readline)

# all: $(READLINE_DEP) $(NAME)

# $(NAME): $(LIBFT) $(OBJS) $(INCS) $(READLINE_DEP)
# 	[...]

# **************************************************************************** #
# --------------------------------- READLINE (rules) ------------------------- #
# **************************************************************************** #
install_readline: $(READLINE_SENTINEL)

$(READLINE_SENTINEL):
	@mkdir -p $(READLINE_DIR)
	@echo "$(CYAN)Downloading and installing readline...$(RESET)"
	@if [ ! -f $(READLINE_SRC) ]; then \
		curl -# -o $(READLINE_SRC) $(READLINE_SRC_URL); \
	fi
	@mkdir -p $(READLINE_BUILD_DIR)
	@tar -xf $(READLINE_SRC) -C $(READLINE_BUILD_DIR) --strip-components=1
	@cd $(READLINE_BUILD_DIR) && \
	./configure --prefix=$(PWD)/$(READLINE_INSTALL_DIR) && \
	clear && echo "$(BOLD)$(CYAN)readline$(RESET) is now being built" && \
	make --quiet && \
	clear && echo "$(BOLD)$(CYAN)readline$(RESET) is now being installed" && \
	make install --quiet
	@printf "$(TOP_LEFT)$(ERASE_ALL)"
	@echo "[$(BOLD)$(PURPLE)readline$(RESET)] \
	installed locally in $(CYAN)$(UNDERLINE)$(READLINE_DIR)$(RESET)"
	@touch $@

rclean:
	@if [ -n "$(wildcard $(READLINE_SENTINEL))" ]; then \
		$(REMOVE) $(READLINE_DIR); \
		echo "[$(BOLD)$(PURPLE)readline$(RESET)] \
		$(GREEN)all files removed$(RESET)"; \
	else \
		echo "[$(BOLD)$(PURPLE)readline$(RESET)] \
		$(YELLOW)No readline to clean$(RESET)"; \
	fi

.PHONY: install_readline rclean

# 

# TOP_LEFT	:= $(ESC)[1;1H
# ERASE_ALL	:= $(ESC)[2J
# (if using both, maybe use 'clear'...?)
