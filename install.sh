#!/usr/bin/env bash

## ----------------------------------------------------------------------
## Create symlinks to files.
##
## Read README.md for details.
## ----------------------------------------------------------------------

ln -sf ${PWD}/files/gitconfig_generic ~/.gitconfig_generic
ln -sf ${PWD}/files/git-completion.bash ~/.git-completion.bash
ln -sf ${PWD}/files/git_commit_template.txt ~/.git_commit_template.txt

if test "$(uname)" = "Darwin"
then
    FILE=${PWD}/files/gitconfig__just_for_Darwin__
else
    FILE=${PWD}/files/gitconfig__just_for_Linux__
fi

ln -sf $FILE ~/.gitconfig
