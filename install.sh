#!/usr/bin/env bash

## ----------------------------------------------------------------------
## Create symlinks to files.
##
## Read README.md for details.
## ----------------------------------------------------------------------

ln -sf ${PWD}/files/git-completion.bash ~/.git-completion.bash

if test "$(uname)" = "Darwin"
then
    FILE=${PWD}/files/gitconfig__just_for_Darwin__
else
    FILE=${PWD}/files/gitconfig__just_for_Linux__
fi

ln -sf $FILE ~/.gitconfig
