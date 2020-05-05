#!/usr/bin/env bash

if [[ "$(uname)" = "Darwin" ]]; then
    filename=~/.bashrc
else
    filename=~/.bash_aliases
fi

if [[ -r ${filename} ]]; then
    mv ${filename} ${filename}.$(date +%Y-%m-%d.%H-%M)
fi
ln -s ${PWD}/bashrc ${filename}

ln -s ${PWD}/ps1_colors.example ~/.ps1_colors
ln -s ${PWD}/ps1_hostname_alias.example ~/.ps1_hostname_alias
ln -s ${PWD}/pyenv_global_command.example ~/.pyenv_global_command
