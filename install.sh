#!/usr/bin/env bash

if [[ -r ~/.bash_aliases ]]; then
	mv ~/.bash_aliases ~/.bash_aliases.$(date +%Y-%m-%d.%H-%M)
fi

ln -s ${PWD}/bashrc ~/.bash_aliases
ln -s ${PWD}/ps1_colors.example ~/.ps1_colors
ln -s ${PWD}/ps1_hostname_alias.example ~/.ps1_hostname_alias
