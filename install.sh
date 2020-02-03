#!/usr/bin/env bash

# See README.md, please.
#
# Reference for these dirs: https://specifications.freedesktop.org/basedir-spec/0.6/ar01s03.html

XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-~/.config}
XDG_DATA_HOME=${XDG_DATA_HOME:-~/.local/share}

NEOVIM_CONFIG_DIR=${XDG_CONFIG_HOME}/nvim
NEOVIM_DATA_DIR=${XDG_DATA_HOME}/nvim
NEOVIM_PLUGINS_DIR=${NEOVIM_DATA_DIR}/vim-plug

rm -f ${NEOVIM_CONFIG_DIR}
ln -sf $PWD ${NEOVIM_CONFIG_DIR}
ln -sf $PWD ~/.vimrc
mkdir --parent ${NEOVIM_PLUGINS_DIR}


# Download vim-plug to an autoload directory
curl -fLo ${NEOVIM_DATA_DIR}/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
