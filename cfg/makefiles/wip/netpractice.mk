
OPEN		:=
OPEN_URL	:=
BROWSER		:= Google Chrome

ifeq ($(OS),Darwin)
	OPEN := open
	OPEN_URL := open -a "$(BROWSER)"
else
	OPEN := xdg-open
	OPEN_URL := xdg-open
endif

# **************************************************************************** #
# ---------------------------------- NET ------------------------------------- #
# **************************************************************************** #
TRAIN		:= net_practice.1.5.tgz
TRAIN_URL	:= $(GIT_URL)/raw/main/downloads/$(TRAIN)
PORT		:= 8000
URL			:= http://localhost:$(PORT)/net_practice/index.html

net: | $(TMP_DIR)
	@echo "Downloading and setting up training material..."
	@curl -L $(TRAIN_URL) -o $(TMP_DIR)/$(TRAIN)
	@echo "Extracting tarball..."
	@tar -xzf $(TMP_DIR)/$(TRAIN) -C $(TMP_DIR)
	@echo "Starting local web server on port $(PORT)..."
	@cd $(TMP_DIR) && python3 -m http.server $(PORT) &
	@sleep 2 # Wait for the server to start
	@echo "Opening in $(BROWSER)..."
	@$(OPEN_URL) $(URL)

netpractice: | $(TMP_DIR)
	@echo "Launching $(NAME) in $(BROWSER)"
	@$(OPEN_URL) $(TMP_DIR)/net_practice/index.html

# **************************************************************************** #
# --------------------------- LEARNING MATERIAL ------------------------------ #
# **************************************************************************** #
REF_URL1	:=	https://github.com/lpaube/NetPractice
REF_URL2	:=	https://github.com/iimyzf/NetPractice

REF_URL3	:=	https://www.codequoi.com/en/internet-layered-network-architecture/
REF_URL4	:=	https://www.codequoi.com/en/ipv4-addresses-routing-and-subnet-masks/

ref:
	@$(OPEN_URL) $(REF_URL1)
	@$(OPEN_URL) $(REF_URL2)
	@$(OPEN_URL) $(REF_URL3)
	@$(OPEN_URL) $(REF_URL4)


VIDEO_URL	:=	https://www.youtube.com/watch?v=5WfiTHiU4x8&list=WL&index=1&t=1s

video:
	@echo "Launching Youtube tutorial on Subnetting"
	@$(OPEN_URL) $(VIDEO_URL)
