
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

