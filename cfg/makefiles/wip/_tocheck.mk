
ARGS		:= # redefine in command line: 'make run ARGS=Makefile'
# override ARGS = infile.txt # this prevents redefining the 'ARGS' variable

# Redirection variables
STDOUT_NULL		:= >/dev/null
STDERR_STDOUT	:= 2>&1
IN_BACKGROUND	:= &

DATE		:=$(shell date "+%d/%m/%y")
TIME		:=$(shell date "+%H:%M:%S")

# **************************************************************************** #

numbers: ## Open a random number generator URL
	@open https://www.calculatorsoup.com/calculators/statistics/random-number-generator.php


# Assembly...
assembly: $(NAME) | $(TMP_DIR)
	@$(COMPILE) $(C_FLAGS) -S $(SRCS) $(HEADERS)
	@mv *.s $(TMP_DIR)
	@echo "Assembly files created in $(TMP_DIR)"

# **************************************************************************** #
# --------------------------------- EVAL_PIC --------------------------------- #
# **************************************************************************** #
PIC_CHECK	:= ./$(IMG_DIR)/.pic_check
PIC			:= $(if $(wildcard $(PIC_CHECK)),,eval_pic)

# all: $(PIC) $(NAME)

# fclean:
# 	[...]
# 	@$(REMOVE) $(PIC_CHECK)

# **************************************************************************** #
SGOINFRE 		:= ~/sgoinfre/photos_etudiants/*/*
PROFILE_PIC 	:= $(shell whoami).JPG
DESTINATION 	:= ./$(shell whoami)_profile_copy.JPG
PNG_DESTINATION := ./img/evaluator.png
PIC_RESIZE		:= 256

eval_pic: $(PIC_CHECK)

$(PIC_CHECK):
	@if [ ! -f $(PIC_CHECK) ]; then \
		FILE_PATH=$$(find $(SGOINFRE) -name $(PROFILE_PIC) | head -n 1); \
		if [ -z "$$FILE_PATH" ]; then \
			echo "$(RED)Error$(RESET): File $(YELLOW)$(PROFILE_PIC)$(RESET) not found."; \
		else \
			echo "$(GREEN)$(BOLD)Preparing $(ORANGE)$(NAME)$(RESET)"; \
			cp "$$FILE_PATH" $(DESTINATION); \
		fi; \
	fi
	@if [ ! -f $(PIC_CHECK) ]; then \
		sips -s format png $(DESTINATION) --out $(PNG_DESTINATION) > $(VOID) 2>&1; \
		if [ $$? -ne 0 ]; then \
			echo "$(RED)Error$(RESET): Conversion failed."; \
		else \
			$(REMOVE) $(DESTINATION); \
		fi; \
	fi
	@if [ ! -f $(PIC_CHECK) ]; then \
		sips -Z $(PIC_RESIZE) $(PNG_DESTINATION) > $(VOID) 2>&1; \
		if [ $$? -ne 0 ]; then \
			echo "$(RED)Error$(RESET): Resizing failed."; \
		else \
			echo "$(GREEN):)$(RESET)"; \
		fi; \
	fi
	@touch $(PIC_CHECK)
# **************************************************************************** #

colortest:
	@for i in $$(seq 0 255); do \
		printf "\033[38;5;$$i;48;5;$$((i+1))m█$(RESET)"; \
	done

# **************************************************************************** #

FORCE_FLAGS	:= \
-Wno-unused-variable \
-Wno-unused-function

force: C_FLAGS += $(FORCE_FLAGS)
force: re
	@echo "adding flags $(YELLOW)$(FORCE_FLAGS)$(RESET)"
	@echo "$(RED)Forced compilation$(RESET)"
	./$(NAME)

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
# Random sequence for pmergeme cpp09
# 

GENERATED_SEQUENCE	:= $(TMP_DIR)/generated_sequence.txt
SEQUENCE_HYPERLINK	:= \033]8;;file://$(GENERATED_SEQUENCE)\a$(GENERATED_SEQUENCE)\033]8;;\a

rand: all | $(TMP_DIR)
	@read -p "How many values should we generate for $(NAME)? " NUM_VALUES; \
	if [ -z "$$NUM_VALUES" ]; then \
		echo "No value entered. Running $(NAME) without arguments."; \
		./$(NAME); \
	elif [ $$NUM_VALUES -gt 0 ]; then \
		if [ "$(shell uname)" = "Linux" ]; then \
			RAND_SEQUENCE=$$(shuf -i 1-$$NUM_VALUES -n $$NUM_VALUES | tr '\n' ' '); \
		else \
			RAND_SEQUENCE=$$(awk -v n=$$NUM_VALUES 'BEGIN{srand(); max=2*n; \
				for(i=0; i<n; i++) { \
					do { \
						r=int(rand()*max); \
					} while(r in seen || r < 0); \
					seen[r]=1; \
					printf r" "; \
				} \
			}'); \
		fi; \
		printf "$(UP)$(ERASE_LINE)"; \
		if [ $$NUM_VALUES -gt 40 ]; then \
			echo $$RAND_SEQUENCE > $(GENERATED_SEQUENCE); \
			echo "Generated input sequence written in $(BLUE)$(SEQUENCE_HYPERLINK)$(RESET)\n"; \
		fi; \
		./$(NAME) $$RAND_SEQUENCE; \
	else \
		echo "Error: Invalid number of values, must be greater than 0."; \
		exit 1; \
	fi

# RAND_SEQUENCE=$$(awk -v n=$$NUM_VALUES 'BEGIN{srand(); for(i=1; i<=n; i++) a[i]=i; for(i=n; i>0; i--){j=int(rand()*i)+1; printf a[j]" "; a[j]=a[i]}}'); # <- N shuffled numbers from 1 to N
# RAND_SEQUENCE=$$(awk -v n=$$NUM_VALUES 'BEGIN{srand(); max=2*n; for(i=0; i<n; i++){do{r=int(rand()*max)} while(r in seen || r < 0); seen[r]=1; printf r" "}}'); <- N shuffled numbers from 0 to N*2 ?

run: rand ## Compile and run the executable with randomized sequence argument



# **************************************************************************** #
# ----------------------------------- INFO ----------------------------------- #
# **************************************************************************** #
define INFO

$(NAME)
by $(AUTHOR)


$(UNDERLINE)Compiler$(RESET)
$(COMPILE)

$(UNDERLINE)C_FLAGS$(RESET)
 $(C_FLAGS)

$(UNDERLINE)I_FLAGS$(RESET)
$(HEADERS)

$(UNDERLINE)L_FLAGS$(RESET)
$(L_FLAGS)

$(UNDERLINE)Header files$(RESET)
$(INCS)

$(UNDERLINE)Source code$(RESET)
$(SRCS)

$(UNDERLINE)Libraries$(RESET)
$(LIBFT) $(MLX42)

$(UNDERLINE)Screen resolution$(RESET)
Width: $(SCREEN_W)
Height:$(SCREEN_H)

endef
export INFO

info:
	@echo "$$INFO"

.PHONY: info

# **************************************************************************** #
# -------------------------------- MISC INFO --------------------------------- #
# **************************************************************************** #

# https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html
# -Ofast	-> 
# -flto		-> link-time optimisation

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
