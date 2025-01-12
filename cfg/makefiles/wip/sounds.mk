
# **************************************************************************** #
# --------------------------------- SOUNDS ----------------------------------- #
# **************************************************************************** #
# https://sound-effects.bbcrewind.co.uk/
# https://soundbible.com/
# or convert youtube/mp3/etc. to .wav
# **************************************************************************** #
WAV_DIR		:= wav
WAV_DESTROY	:= $(WAV_DIR)/destroy.wav

sound:
	@echo "testing a .wav sound"
	@$(SOUND) $(WAV_DESTROY)
	@echo "sound testing finished"

.PHONY: sound