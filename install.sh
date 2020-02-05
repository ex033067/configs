#!/usr/bin/env bash

if [[ -r ~/.bash_aliases ]]; then
	mv ~/.bash_aliases ~/.bash_aliases.$(date +%Y-%m-%d.%H-%M)
fi

ln -s ${PWD}/bashrc ~/.bash_aliases
ln -s ${PWD}/ps1colorrc.example ~/.ps1colorrc
