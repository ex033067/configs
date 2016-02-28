#!/usr/bin/env bash

## ----------------------------------------------------------------------
## Create symlinks to files.
##
## Read README.md for details.
## ----------------------------------------------------------------------

ln -sf ${PWD}/files/gitconfig ~/.gitconfig
ln -sf ${PWD}/files/git-completion.bash ~/.git-completion.bash
ln -sf ${PWD}/files/git_commit_template.txt ~/.git_commit_template.txt

if test "$(uname)" = "Darwin"
then
    local FILE=${PWD}/files/gitconfig_os_specific__Darwin
else
    local FILE=${PWD}/files/gitconfig_os_specific__Linux
fi

ln -sf $FILE ~/.gitconfig_os_specific
