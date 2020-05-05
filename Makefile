# For reference: https://makefiletutorial.com

.PHONY: help
help :
	@echo 'Run "make install" to update your environment'

.PHONY: install
install :
	@cd bash \
		&& ./install
	@cd git \
		&& ./install
	@cd tmux \
		&& ./install
