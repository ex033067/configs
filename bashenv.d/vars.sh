#  vim: filetype=sh

export PROJECT_ROOT=~/projects

[ -z "$TMPDIR" ] && export TMPDIR=/tmp

export HISTCONTROL=ignoreboth
export EDITOR='vim'
export VISUAL=$EDITOR

[ -d /hd2/.vagrant.d ] && export VAGRANT_HOME=/hd2/.vagrant.d
export VAGRANT_BOX_UPDATE_CHECK_DISABLE=1

[ -d ~/.local/bin/virtualenvs ] \
    && export VIRTUAL_ENV_ROOT=~/.local/bin/virtualenvs \
    || export VIRTUAL_ENV_ROOT=~/virtualenvs

[ -d ~/.local/bin/pyenv ] \
    && export PYENV_ROOT=~/.local/bin/pyenv \
    || export PYENV_ROOT=~/.pyenv

PATH="$HOME/bin:$HOME/.local/bin:$PYENV_ROOT/bin:/usr/local/bin:$PATH"

[ -n "$VIRTUAL_ENV" ] && PATH="$VIRTUAL_ENV/bin:$PATH"
