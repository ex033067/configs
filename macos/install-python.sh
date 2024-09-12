#!/usr/bin/env bash

brew install asdf
brew install openssl readline sqlite3 xz zlib tcl-tk  # for pyenv under asdf
brew install pipx
pipx ensurepath

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
