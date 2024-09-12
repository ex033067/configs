#!/usr/bin/env bash

# Install Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Install formulaes
brew install bash
brew install git
brew install tmux
brew install tree
brew install wget
brew install ack
brew install the_silver_searcher  # hg
brew install ripgrep  # rg
brew install neovim
brew install macvim
brew install ctags
brew install asdf
brew install openssl readline sqlite3 xz zlib tcl-tk  # for pyenv under asdf
brew install pipx
pipx ensurepath

brew install yt-dlp # new youtube-dl

# activate asdf
. /opt/homebrew/opt/asdf/libexec/asdf.sh

# Install Python plugin for asdf (pyenv)
asdf plugin-add python
asdf install python latest:3.10
asdf install python latest:3.11

# Install stuff with pipx
## pipx install jupyter
## pipx inject jupyter numpy
pipx install black
pipx install docformatter
pipx install isort
pipx install pre-commit
pipx install poetry
