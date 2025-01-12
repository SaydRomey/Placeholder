
GRADEME_FILE			:= 42-EXAM

all: ## Main menu for project actions
	@echo "$(BOLD)Choose an action:$(RESET)"
	@echo "0) Launch JCluzet's GRADEME"
	@read -p "Enter your choice: " choice; \
	case $$choice in \
		0) $(MAKE) $(NPD) exam ;; \
		*) $(call ERROR,Invalid choice:,$$choice) ;; \
	esac

# 📝 Exam Simulator
exam: ## Launch JCluzet's GRADEME
	@read -p "Are you sure you want to launch GRADEME? (y/n): " confirm; \
	if [ "$$confirm" = "y" ]; then \
		bash -c "$$(curl https://grademe.fr)"; \
	else \
		$(call WARNING,Action cancelled:,GRADEME was not launched); \
	fi

clean-exam:
	@$(REMOVE) $(GRADEME_FILE)
