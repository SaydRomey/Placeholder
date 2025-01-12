
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

# 
# (in libft,s Makefile):
# 

# **************************************************************************** #
# -------------------------------- NORMINETTE -------------------------------- #
# **************************************************************************** #
norm:
	@echo "$(BOLD)$(YELLOW)Norminetting $(PURPLE)$(NAME)$(RESET)"
	@norminette -o $(INCS)
	@norminette -o $(SRCS)

nm:
	@echo "$(BOLD)$(YELLOW)Functions in $(PURPLE)$(UNDERLINE)$(NAME)$(RESET):"
	@nm $(NAME) | grep U | grep -v 'ft_' \
				| sed 's/U//g' | sed 's/__//g' | sed 's/ //g' \
				| sort | uniq

.PHONY: norm nm
# **************************************************************************** #
# ------------------------------- DECORATIONS -------------------------------- #
# **************************************************************************** #
define TITLE

██      ██ ██████  ███████ ████████ 
██      ██ ██   ██ ██         ██    
██      ██ ██████  █████      ██    
██      ██ ██   ██ ██         ██    
███████ ██ ██████  ██         ██   

endef
export TITLE
