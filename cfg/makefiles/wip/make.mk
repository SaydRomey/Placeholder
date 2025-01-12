
# **************************************************************************** #
# ---------------------------------- NEW ------------------------------------- #
# **************************************************************************** #
PASSWORD			:=	sudo
MAKEFILE_TEMPLATE	:=	Misc/Makefile.template

new:
	@echo "Select the CPP module:"
	@echo "0. Module 00"
	@echo "1. Module 01"
	@echo "2. Module 02"
	@echo "3. Module 03"
	@echo "4. Module 04"
	@echo "5. Module 05"
	@echo "6. Module 06"
	@echo "7. Module 07"
	@echo "8. Module 08"
	@echo "9. Module 09"
	@read module_choice; \
	case $$module_choice in \
		0) MODULE_NUM=00;; \
		1) MODULE_NUM=01;; \
		2) MODULE_NUM=02;; \
		3) MODULE_NUM=03;; \
		4) MODULE_NUM=04;; \
		5) MODULE_NUM=05;; \
		6) MODULE_NUM=06;; \
		7) MODULE_NUM=07;; \
		8) MODULE_NUM=08;; \
		9) MODULE_NUM=09;; \
		*) echo "Invalid choice. Exiting." ; exit 1;; \
	esac; \
	echo "Enter exercise number (e.g., 00, 01): "; \
	read exnum; \
	exdir="CPP$$MODULE_NUM/ex$$exnum"; \
	if [ -d "$$exdir" ]; then \
		echo "$$exdir already exists. Overwrite? [y/N]: "; \
		read overwrite_choice; \
		if [ "$$overwrite_choice" = "y" ] || [ "$$overwrite_choice" = "Y" ]; then \
			echo "Enter password: "; \
			read user_password; \
			if [ "$$user_password" != "$(PASSWORD)" ]; then \
				echo "Incorrect password. Exiting."; \
				exit 1; \
			fi; \
		else \
			echo "Keeping $$exdir as it was..."; \
			exit 1; \
		fi; \
	fi; \
	mkdir -p $$exdir/$(SRC_DIR) $$exdir/$(INC_DIR); \
	echo "$$MAIN_CPP" > $$exdir/$(SRC_DIR)/main.cpp; \
	cp $(MAKEFILE_TEMPLATE) $$exdir/Makefile; \
	if [ "$(OS)" = "Darwin" ]; then \
		sed -i '' "s/cpp00/cpp$$MODULE_NUM/" $$exdir/Makefile; \
	else \
		sed -i "s/cpp00/cpp$$MODULE_NUM/" $$exdir/Makefile; \
	fi; \
	echo "Should we create a new class? [y/N]: "; \
	read create_class; \
	if [ "$$create_class" = "y" ] || [ "$$create_class" = "Y" ]; then \
		(cd $$exdir; $(MAKE) class $(NPD)); \
	fi; \
	echo "Created exercise environment in $$exdir"

.PHONY: new
# **************************************************************************** #
# ------------------------------- TEMPLATES ---------------------------------- #
# **************************************************************************** #
define MAIN_CPP
/*
*/


int	main(int argc, char *argv[])
{
	(void)argc;
	(void)argv;

	return (0);
}

endef

export MAIN_CPP
